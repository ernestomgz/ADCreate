# ADBuilder

ADBuilder is a project designed to streamline the configuration of Active Directory for testing purposes using Packer. It provides a quick and efficient solution for setting up a Windows Server VM, configuring AD DS, and managing AD Certificates.

## Prerequisites

Before using ADBuilder, ensure you have Packer installed.


## Getting Started

1. Clone this repository.

2. Execute the `./init.sh` commands to build and configure your Windows Server VM.

3. Add the generated .ovf file to VirtualBox. After the initialization is complete, the VM will be create at './VMCreate/output-gen/' .Add the generated .ovf file to your VirtualBox environment to create a fully configured Active Directory test environment.

## How it works

1. **Configure Windows Server VM:**
   Uses Packer to create a Windows Server VM with the necessary configurations.

2. **Set up AD DS and AD Certificates:**
   Using scripts it automatically configures AD DS and manage AD Certificates.

3. **Automate User and Group Creation:**
   Automates the creation of AD users and groups, simplifying the preparation of your Active Directory environment for testing scenarios.
