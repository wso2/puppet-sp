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
}
