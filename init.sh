#!/bin/bash
cd ./VMCreate
packer build -only=virtualbox-iso.gen -var 'fast=true' win2019-gui_uefi.pkr.hcl
