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

# Class: sp_worker
# Init class of stream processor all in one profile
class sp_worker (
  $user                 = $sp_worker::params::user,
  $user_id              = $sp_worker::params::user_id,
  $user_group           = $sp_worker::params::user_group,
  $user_group_id        = $sp_worker::params::user_group_id,
  $product_name         = $sp_worker::params::product_name,
  $service_name         = $sp_worker::params::service_name,
  $service_profile = $sp_worker::params::service_profile,
  $start_script_template = $sp_worker::params::start_script_template,
  $deployment_yaml_template = $sp_worker::params::deployment_yaml_template,
  $jre_version = $sp_worker::params::jre_version,
  $clustering = $sp_worker::params::clustering,

  # -------- deployment.yaml configs --------

  # listenerConfigurations
  $default_host = $sp_worker::params::default_host,

  $msf4j_host = $sp_worker::params::msf4j_host,
  $msf4j_keystore_file = $sp_worker::params::msf4j_keystore_file,
  $msf4j_keystore_password = $sp_worker::params::msf4j_keystore_password,
  $msf4j_cert_pass = $sp_worker::params::msf4j_cert_pass,

  # Configuration used for the databridge communication
  $databridge_keystore_location = $sp_worker::params::databridge_keystore_location,
  $databridge_keystore_password = $sp_worker::params::databridge_keystore_password,
  $binary_data_receiver_hostname = $sp_worker::params::binary_data_receiver_hostname,

  # Configuration of the Data Agents - to publish events through databridge
  $thrift_agent_trust_store = $sp_worker::params::thrift_agent_trust_store,
  $thrift_agent_trust_store_password = $sp_worker::params::thrift_agent_trust_store_password,
  $binary_agent_trust_store = $sp_worker::params::binary_agent_trust_store,
  $binary_agent_trust_store_password = $sp_worker::params::binary_agent_trust_store_password,

  # Secure Vault Configuration
  $securevault_private_key_alias = $sp_worker::params::securevault_private_key_alias,
  $securevault_keystore = $sp_worker::params::securevault_keystore,
  $securevault_secret_properties_file = $sp_worker::params::securevault_secret_properties_file,
  $securevault_master_key_reader_file = $sp_worker::params::securevault_master_key_reader_file,

  # Datasource Configurations
  $carbon_db_url = $sp_worker::params::carbon_db_url,
  $carbon_db_username = $sp_worker::params::carbon_db_username,
  $carbon_db_password = $sp_worker::params::carbon_db_password,
  $carbon_db_dirver = $sp_worker::params::carbon_db_dirver,

  # Cluster Configuration
  $cluster_enabled = $sp_worker::params::cluster_enabled,
)
inherits sp_worker::params {

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
