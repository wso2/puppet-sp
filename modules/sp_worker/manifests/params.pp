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

# Claas sp_worker::params
# This class includes all the necessary parameters
class sp_worker::params inherits sp_common::params {

  # Define the template
  $start_script_template = "bin/worker.sh"

  # Define the template
  $template_list = [
    'conf/worker/deployment.yaml'
  ]

  # Define file list
  $file_list = []

  # Define remove file list
  $file_removelist = []

  # -------- deployment.yaml configs --------

  # listenerConfigurations
  $default_host = '0.0.0.0'
  $msf4j_host = '0.0.0.0'
  $msf4j_keystore_file = '${carbon.home}/resources/security/wso2carbon.jks'
  $msf4j_keystore_password = 'wso2carbon'
  $msf4j_cert_pass = 'wso2carbon'

  $siddhi_default_host = '0.0.0.0'
  $siddhi_msf4j_host = '0.0.0.0'
  $siddhi_msf4j_keystore = '${carbon.home}/resources/security/wso2carbon.jks'
  $siddhi_msf4j_keystore_password = 'wso2carbon'
  $siddhi_msf4j_cert_pass = 'wso2carbon'

  # Datasource Configurations
  $carbon_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/WSO2_CLUSTER_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;AUTO_SERVER=TRUE'
  $carbon_db_username = 'wso2carbon'
  $carbon_db_password = 'wso2carbon'
  $carbon_db_dirver = 'org.h2.Driver'

  # Cluster Configuration
  $cluster_enabled = 'false'
}
