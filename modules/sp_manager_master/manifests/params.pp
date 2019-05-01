# ----------------------------------------------------------------------------
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
# ----------------------------------------------------------------------------

# Claas sp_manager_master::params
# This class includes all the necessary parameters
class sp_manager_master::params {
  $user = 'wso2carbon'
  $user_group = 'wso2'
  $product = 'wso2sp'
  $product_version = '4.3.0'
  $product_profile = 'manager'

  # Define the template
  $deployment_yaml_template = "conf/${product_profile}/deployment.yaml"

  # -------- deployment.yaml configs --------

  # listenerConfigurations
  $default_host = '0.0.0.0'

  $msf4j_host = '0.0.0.0'
  $msf4j_keystore_file = '${carbon.home}/resources/security/wso2carbon.jks'
  $msf4j_keystore_password = 'wso2carbon'
  $msf4j_cert_pass = 'wso2carbon'

  # Configuration used for the databridge communication
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

  # Datasource Configurations
  $mgt_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/SP_MGT_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
  $mgt_db_username = 'wso2carbon'
  $mgt_db_password = 'wso2carbon'
  $mgt_db_dirver = 'org.h2.Driver'

  # Cluster Configuration
  $cluster_enabled = 'false'

  # Directories
  $products_dir = "/usr/local/wso2"

  # Product and installation paths
  $product_binary = "${product}-${product_version}.zip"
  $distribution_path = "${products_dir}/${product}/${product_profile}/${product_version}"
  $install_path = "${distribution_path}/${product}-${product_version}"
}
