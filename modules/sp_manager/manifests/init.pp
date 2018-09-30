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

# Class: sp_manager
# Init class of stream processor - Manager profile
class sp_manager inherits sp_manager::params {

  if $::osfamily == 'redhat' {
    $sp_package = 'wso2sp-linux-installer-x64-4.3.0.rpm'
    $installer_provider = 'rpm'
    $install_path = '/usr/lib64/wso2/wso2sp/4.3.0'
  }
  elsif $::osfamily == 'debian' {
    $sp_package = 'wso2sp-linux-installer-x64-4.3.0.deb'
    $installer_provider = 'dpkg'
    $install_path = '/usr/lib/wso2/wso2sp/4.3.0'
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