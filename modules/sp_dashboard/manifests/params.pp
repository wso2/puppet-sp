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

# Claas sp_dashboard::params
# This class includes all the necessary parameters
class sp_dashboard::params {
  $user = 'wso2carbon'
  $user_id = 802
  $user_group = 'wso2'
  $user_home = '/home/$user'
  $user_group_id = 802
  $product_name = 'wso2sp'
  $product_profile = 'dashboard'
  $service_name = "${product_name}-${product_profile}"
  $jre_version = 'jre1.8.0_172'

  # Define the template
  $start_script_template = "bin/${product_profile}.sh"
  $deployment_yaml_template = "conf/${product_profile}/deployment.yaml"

  # -------- deployment.yaml configs --------

  # databridge.config
  $databridge_keystore_location = '${sys:carbon.home}/resources/security/wso2carbon.jks'
  $databridge_keystore_password = 'wso2carbon'
  $binary_data_receiver_hostname = '0.0.0.0'

  # data.agent.config
  $thrift_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $thrift_agent_trust_store_password = 'wso2carbon'
  $binary_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $binary_agent_trust_store_password = 'wso2carbon'

  # wso2.securevault
  $securevault_private_key_alias = 'wso2carbon'
  $securevault_key_store = '${sys:carbon.home}/resources/security/securevault.jks'
  $securevault_secret_properties_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/secrets.properties'
  $securevault_master_key_reader_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/master-keys.yaml'

  # wso2.datasources
  $dashboard_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/DASHBOARD_DB;IFEXISTS=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
  $dashboard_db_username = 'wso2carbon'
  $dashboard_db_password = 'wso2carbon'
  $dashboard_db_driver = 'org.h2.Driver'

  $business_rules_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/BUSINESS_RULES_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
  $business_rules_db_username = 'wso2carbon'
  $business_rules_db_password = 'wso2carbon'
  $business_rules_db_driver = 'org.h2.Driver'

  $status_dashboard_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/wso2_status_dashboard;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
  $status_dashboard_db_username = 'wso2carbon'
  $status_dashboard_db_password = 'wso2carbon'
  $status_dashboard_db_driver = 'org.h2.Driver'

  $metrics_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/metrics;AUTO_SERVER=TRUE'
  $metrics_db_username = 'wso2carbon'
  $metrics_db_password = 'wso2carbon'
  $metrics_db_driver = 'org.h2.Driver'

  # wso2.business.rules.manager
  $business_rules_manager_username = 'admin'
  $businnes_rules_manager_password = 'admin'

  # wso2.status.dashboard
  $worker_access_username = 'admin'
  $worker_access_password = 'admin'

  # listenerConfigurations
  $listener_host = '0.0.0.0'
  $listener_keystore_file = '${carbon.home}/resources/security/wso2carbon.jks'
  $listener_keystore_password = 'wso2carbon'
  $listener_cert_pass = 'wso2carbon'
}
