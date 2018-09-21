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

# Class: sp
# Init class of stream processor all in one profile
class sp_dashboard (
  $user = $sp_dashboard::params::user,
  $user_id = $sp_dashboard::params::user_id,
  $user_group = $sp_dashboard::params::user_group,
  $user_group_id = $sp_dashboard::params::user_group_id,
  $product_name = $sp_dashboard::params::product_name,
  $service_name = $sp_dashboard::params::service_name,
  $service_profile = $sp_dashboard::params::service_profile,
  $start_script_template = $sp_dashboard::params::start_script_template,
  $deployment_yaml_template = $sp_dashboard::params::deployment_yaml_template,
  $jre_version = $sp_dashboard::params::jre_version,

  # -------- deployment.yaml configs --------

  # databridge.config
  $databridge_keystore_location = $sp_dashboard::params::databridge_keystore_location,
  $databridge_keystore_password = $sp_dashboard::params::databridge_keystore_password,
  $binary_data_receiver_hostname = $sp_dashboard::params::binary_data_receiver_hostname,

  # data.agent.config
  $thrift_agent_trust_store = $sp_dashboard::params::thrift_agent_trust_store,
  $thrift_agent_trust_store_password = $sp_dashboard::params::thrift_agent_trust_store_password,
  $binary_agent_trust_store = $sp_dashboard::params::binary_agent_trust_store,
  $binary_agent_trust_store_password = $sp_dashboard::params::binary_agent_trust_store_password,

  # wso2.securevault
  $securevault_private_key_alias = $sp_dashboard::params::securevault_private_key_alias,
  $securevault_key_store = $sp_dashboard::params::securevault_key_store,
  $securevault_secret_properties_file = $sp_dashboard::params::securevault_secret_properties_file,
  $securevault_master_key_reader_file = $sp_dashboard::params::securevault_master_key_reader_file,

  # wso2.datasources
  $dashboard_db_url = $sp_dashboard::params::dashboard_db_url,
  $dashboard_db_username = $sp_dashboard::params::dashboard_db_username,
  $dashboard_db_password = $sp_dashboard::params::dashboard_db_password,
  $dashboard_db_driver = $sp_dashboard::params::dashboard_db_driver,

  $business_rules_db_url = $sp_dashboard::params::business_rules_db_url,
  $business_rules_db_username = $sp_dashboard::params::business_rules_db_username,
  $business_rules_db_password = $sp_dashboard::params::business_rules_db_password,
  $business_rules_db_driver = $sp_dashboard::params::business_rules_db_driver,

  $status_dashboard_db_url = $sp_dashboard::params::status_dashboard_db_url,
  $status_dashboard_db_username = $sp_dashboard::params::status_dashboard_db_username,
  $status_dashboard_db_password = $sp_dashboard::params::status_dashboard_db_password,
  $status_dashboard_db_driver = $sp_dashboard::params::status_dashboard_db_driver,

  $metrics_db_url = $sp_dashboard::params::metrics_db_url,
  $metrics_db_username = $sp_dashboard::params::metrics_db_username,
  $metrics_db_password = $sp_dashboard::params::metrics_db_password,
  $metrics_db_driver = $sp_dashboard::params::metrics_db_driver,

  # wso2.business.rules.manager
  $business_rules_manager_username = $sp_dashboard::params::business_rules_manager_username,
  $businnes_rules_manager_password = $sp_dashboard::params::businnes_rules_manager_password,

  # wso2.status.dashboard
  $worker_access_username = $sp_dashboard::params::worker_access_username,
  $worker_access_password = $sp_dashboard::params::worker_access_password,

  # listenerConfigurations
  $listener_host = $sp_dashboard::params::listener_host,
  $listener_keystore_file = $sp_dashboard::params::listener_keystore_file,
  $listener_keystore_password = $sp_dashboard::params::listener_keystore_password,
  $listener_cert_pass = $sp_dashboard::params::listener_cert_pass,

)
inherits sp_dashboard::params {

  if $::osfamily == 'redhat' {
    $sp_package = 'wso2sp-linux-installer-x64-4.2.0.rpm'
    $installer_provider = 'rpm'
    $install_path = '/usr/lib64/wso2/wso2sp/4.2.0'
  }
  elsif $::osfamily == 'debian' {
    $sp_package = 'wso2sp-linux-installer-x64-4.2.0.deb'
    $installer_provider = 'dpkg'
    $install_path = '/usr/lib/wso2/wso2sp/4.2.0'
  }

  # Create wso2 group
  group { $user_group:
    ensure => present,
    gid    => $user_group_id,
    system => true,
  }

  # Create wso2 user
  user { $user:
    ensure => present,
    uid    => $user_id,
    gid    => $user_group_id,
    home   => "/home/${user}",
    system => true,
  }
  # Ensure the installation directory is available
  file { "/opt/${product_name}":
    ensure => 'directory',
    owner  => $user,
    group  => $user_group,
  }

  # Copy the installer to the directory
  file { "/opt/${product_name}/${sp_package}":
    owner  => $user,
    group  => $user_group,
    mode   => '0644',
    source => "puppet:///modules/${module_name}/${sp_package}",
  }

  # Install WSO2 Stream Processor
  package { $product_name:
    ensure   => installed,
    provider => $installer_provider,
    source   => "/opt/${product_name}/${sp_package}"
  }

  # Change the ownership of the installation directory to wso2 user & group
  file { $install_path:
    ensure  => directory,
    owner   => $user,
    group   => $user_group,
    require => [ User[$user], Group[$user_group]],
    recurse => true
  }

  # Copy deployment.yaml to the installed directory
  file { "${install_path}/${deployment_yaml_template}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0644',
    content => template("${module_name}/carbon-home/${deployment_yaml_template}.erb")
  }

  # Copy dashboard.sh to installed directory
  file { "${install_path}/${start_script_template}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0754',
    content => template("${module_name}/carbon-home/${start_script_template}.erb")
  }

  # Copy the unit file required to deploy the server as a service
  file { "/etc/systemd/system/${service_name}.service":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0754',
    content => template("${module_name}/${service_name}.service.erb"),
  }

  /*
    Following script can be used to copy file to a given location.
    This will copy some_file to install_path -> repository.
    Note: Ensure
    that file is available in modules -> sp_dashboard -> files
  */
  # file { "${install_path}/repository/some_file":
  #   owner  => $user,
  #   group  => $user_group,
  #   mode   => '0644',
  #   source => "puppet:///modules/${module_name}/some_file",
  # }
}
