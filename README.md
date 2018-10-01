# WSO2 Stream Processor 4.3.0 Puppet 5 Modules

This repository contains puppet modules for each runtime relates to Stream Processor.

## Quick Start Guide
1. Download and copy the `wso2sp-linux-installer-x64-4.3.0.deb` or/and `wso2sp-linux-installer-x64-4.3.0.rpm` to the files directories in `/etc/puppet/code/environments/dev/modules/__runtime__/files` in the Puppetmaster. <br>
`__runtime__` refers to each runtime in Stream Processor. <br>
eg: `/etc/puppet/code/environments/dev/modules/sp/files` <br>
Dev refers to the sample environment that you can try these modules.

2. Run necessary runtime on puppet agent. More details on this are available in the following section.

## Running Stream Processor Runtimes in Puppet Agent
This section describes how to run each Stream Processor runtime in a puppet agent.

### Dashboard runtime
```bash
export FACTER_runtime=sp_dashboard
puppet agent -vt
```

### Worker runtime
```bash
export FACTER_runtime=sp_worker
puppet agent -vt
```

### Manager runtime
```bash
export FACTER_runtime=sp_manager
puppet agent -vt
```

### Editor runtime
```bash
export FACTER_runtime=sp_editor
puppet agent -vt
```

## Understanding the Project Structure
In this project each runtime of Stream Processor is mapped to a module in puppet.
By having this structure each puppet module is considered as a standalone runtime
so each module can be configured individually without harming any other module.

```
puppet-sp
├── manifests
│   └── site.pp
└── modules
    ├── sp_dashboard
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    ├── sp_worker
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    ├── sp_manager
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    └── sp_editor
        ├── files
        │   └── ...
        ├── manifests
        │   ├── init.pp
        │   ├── custom.pp
        │   ├── params.pp
        │   └── startserver.pp
        └── templates
            └── ...

```

### Manifests in a module
Each puppet module contains following pp files
- init.pp <br>
This contains the main script of the module.
- custom.pp <br>
This is used to add custom user code to the runtime.
- params.pp <br>
This contains all the necessary parameters for main configurations and template rendering.
- startserver.pp <br>
This runs finally and starts the server as a service.
