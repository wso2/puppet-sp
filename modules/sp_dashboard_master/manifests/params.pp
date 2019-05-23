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

# Claas sp_dashboard_master::params
# This class includes all the necessary parameters
class sp_dashboard_master::params inherits common::params {
  $user = 'wso2carbon'
  $user_group = 'wso2'
  $product = 'wso2sp'
  $product_version = '4.4.0'
  $product_profile = 'dashboard'

  # Define the template
  $deployment_yaml_template = "conf/${product_profile}/deployment.yaml"

  # -------- deployment.yaml configs --------

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

  $metrics_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/metrics;AUTO_SERVER=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
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

  # Directories
  $products_dir = "/usr/local/wso2"

  # Product and installation paths
  $product_binary = "${product}-${product_version}.zip"
  $distribution_path = "${products_dir}/${product}/${product_profile}/${product_version}"
  $install_path = "${distribution_path}/${product}-${product_version}"
}
