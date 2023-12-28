## Prerequisites

- [Packer](https://www.packer.io/downloads.html)
  - <https://www.packer.io/intro/getting-started/install.html>
- A Hypervisor
  - [VMware Workstation](https://www.vmware.com/products/workstation-pro.html)
  - [Oracle VM VirtualBox](https://www.virtualbox.org/)

## How to use Packer

Commands to create an automated VM image:

To create a Windows Server 2019 VM image using VMware Workstation use the following commands:

```sh
packer build -only=vmware-iso win2019-gui_uefi.pkr.hcl #Windows Server 2019 w/ GUI using UEFI
```

To create a Windows Server 2019 VM image using Oracle VM VirtualBox use the following commands:

```sh
packer build -only=virtualbox-iso win2019-gui_uefi.pkr.hcl #Windows Server 2019 w/ GUI using UEFI
```

*If you want fast deploy of vm use `-var '-fast=true'` . WARNING: The os wont be updated and hypervisor plugins wont be applied.

By default the .iso of Windows Server 2019 is pulled from <https://software-download.microsoft.com/download/pr/17763.1.180914-1434.rs5_release_SERVER_EVAL_X64FRE_EN-US.ISO>


## Default credentials

The default credentials for this VM image are:

|Username|Password|
|--------|--------|
|administrator|packer|
