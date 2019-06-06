# ----------------------------------------------------------------------------
#  Copyright (c) 2018 WSO2, Inc. http://www.wso2.org
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
# ----------------------------------------------------------------------------

# Claas sp_manager::params
# This class includes all the necessary parameters
class sp_manager::params {
  $user = 'wso2carbon'
  $user_group = 'wso2'
  $product = 'wso2sp'
  $product_version = '4.4.0'
  $product_profile = 'manager'
  $service_name = "${product}-${product_profile}"

  # JDK Distributions
  if $::osfamily == 'redhat' {
    $lib_dir = "/usr/lib64/wso2"
  }
  elsif $::osfamily == 'debian' {
    $lib_dir = "/usr/lib/wso2"
  }
  $jdk_name = 'amazon-corretto-8.202.08.2-linux-x64'
  $java_home = "${lib_dir}/${jdk_name}"

  # Define the template
  $start_script_template = "bin/${product_profile}.sh"

  # Define the template
  $template_list = [
    'conf/manager/deployment.yaml'
  ]

  # -------- deployment.yaml configs --------

  # listenerConfigurations
  $default_host = '0.0.0.0'

  $msf4j_host = '0.0.0.0'
  $msf4j_keystore_file = '${carbon.home}/resources/security/wso2carbon.jks'
  $msf4j_keystore_password = 'wso2carbon'
  $msf4j_cert_pass = 'wso2carbon'

  # Datasource Configurations
  $mgt_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/SP_MGT_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
  $mgt_db_username = 'wso2carbon'
  $mgt_db_password = 'wso2carbon'
  $mgt_db_dirver = 'org.h2.Driver'

  # Cluster Configuration
  $cluster_enabled = 'false'
}
