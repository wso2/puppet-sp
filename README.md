# Puppet Modules for WSO2 Stream Processor

This repository contains the Puppet modules for WSO2 Stream Processor.

## Quick Start Guide
1. Download a product package. Product packages can be downloaded and copied to a local directory, or downloaded from a remote location.
  * **Local**: Download a wso2sp-4.4.0.zip pack to your preferred deployment pattern and copy it to the `<puppet_environment>/modules/sp_common/files/packs` directory in the **Puppetmaster**.
  * **Remote**: 
      1. Change the value *$pack_location* variable in `<puppet_environment>/modules/sp_common/manifests/params.pp` to `remote`.
      2. Change the value *$remote_pack* variable of the relevant profile in `<puppet_environment>/modules/sp_common/manifests/params.pp` to the URL in which the package should be downloaded from, and remove it as a comment.

2. Set up the JDK distribution as follows:

   The Puppet modules for WSO2 products use Amazon Corretto as the JDK distribution. However, you can use any [supported JDK distribution](https://docs.wso2.com/display/compatibility/Tested+Operating+Systems+and+JDKs). The JDK Distribution can be downloaded and copied to a local directory, or downloaded from a remote location.
     * **local**: Download Amazon Corretto for Linux x64 from [here](https://docs.aws.amazon.com/corretto/latest/corretto-8-ug/downloads-list.html) and copy .tar into the `<puppet_environment>/modules/sp_common/files/jdk` directory.
     * **remote**: Change the value *$remote_jdk* variable in `<puppet_environment>/modules/sp_common/manifests/params.pp` to the URL in which the JDK should be downloaded from, and remove it as a comment.
     * Reassign the *$jdk_name* variable in `<puppet_environment>/modules/sp_common/manifests/params.pp` to the name of the downloaded JDK distribution.
     
3. Run the relevant profile on the **Puppet agent**.
    1. Dashboard profile:
        ```bash
        export FACTER_runtime=sp_dashboard
        puppet agent -vt
        ```
    2. Editor profile:
       ```bash
       export FACTER_runtime=sp_editor
       puppet agent -vt
       ```
    3. Manager profile:
          ```bash
          export FACTER_runtime=sp_manager
          puppet agent -vt
          ```
    4. Worker profile:
         ```bash
         export FACTER_runtime=sp_worker
         puppet agent -vt
         ```

## Manifests in a module
The run stages for Puppet are described in `<puppet_environment>/manifests/site.pp`, and they are of the order Main -> Custom.

Each Puppet module contains the following .pp files.
* Main
    * params.pp: Contains all the parameters necessary for the main configuration and template
    * init.pp: Contains the main script of the module.
* Custom
    * custom.pp: Used to add custom configurations to the Puppet module.
    