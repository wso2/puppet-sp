#----------------------------------------------------------------------------
#  Copyright (c) 2019 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#----------------------------------------------------------------------------

class sp_common::params {

  $packages = ["unzip"]
  $version = "4.4.0"
  $pack = "wso2sp-${version}"

  # Set the location the product packages should reside in (eg: "local" in the /files directory, "remote" in a remote location)
  $pack_location = "local"
  # $pack_location = "remote"
  # $remote_jdk = "<URL_TO_JDK_FILE>"
  # $remote_pack = "<URL_TO_SP_PACK>"

  $user = 'wso2carbon'
  $user_group = 'wso2'
  $user_id = 802
  $user_group_id = 802

  # Performance tuning configurations
  $enable_performance_tuning = false
  $performance_tuning_flie_list = [
    'etc/sysctl.conf',
    'etc/security/limits.conf',
  ]

  # JDK Distributions
  $java_dir = "/opt"
  $java_symlink = "${java_dir}/java"
  $jdk_name = 'amazon-corretto-8.202.08.2-linux-x64'
  $java_home = "${java_dir}/${jdk_name}"

  $profile = $runtime
  $target = "/mnt"
  $product_dir = "${target}/${profile}"
  $pack_dir = "${target}/${profile}/packs"
  $wso2_service_name = "wso2${profile}"

  # Pack Directories
  $carbon_home = "${product_dir}/${pack}"
  $product_binary = "${pack}.zip"

  # ----- Profile configs -----
  case $profile {
    'sp_dashboard': {
      $server_script_path = "${carbon_home}/bin/dashboard.sh"
      $pid_file_path = "${carbon_home}/wso2/dashboard/runtime.pid"
    }
    'sp_editor': {
      $server_script_path = "${carbon_home}/bin/editor.sh"
      $pid_file_path = "${carbon_home}/wso2/editor/runtime.pid"
    }
    'sp_manager': {
      $server_script_path = "${carbon_home}/bin/manager.sh"
      $pid_file_path = "${carbon_home}/wso2/manager/runtime.pid"
    }
    'sp_worker': {
      $server_script_path = "${carbon_home}/bin/worker.sh"
      $pid_file_path = "${carbon_home}/wso2/worker/runtime.pid"
    }
  }

  # -------- deployment.yaml configs --------

  # databridge.config
  $databridge_keystore_location = '${sys:carbon.home}/resources/security/wso2carbon.jks'
  $databridge_keystore_password = 'wso2carbon'
  $binary_data_receiver_hostname = '0.0.0.0'

  # Configuration of the Data Agents - to publish events through databridge
  $thrift_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $thrift_agent_trust_store_password = 'wso2carbon'
  $binary_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $binary_agent_trust_store_password = 'wso2carbon'

  # Secure Vault Configuration
  $securevault_private_key_alias = 'wso2carbon'
  $securevault_keystore = '${sys:carbon.home}/resources/security/securevault.jks'
  $securevault_secret_properties_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/secrets.properties'
  $securevault_master_key_reader_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/master-keys.yaml'
}
