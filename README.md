android-vm
==========

Automated provisioning and configuration of an Ubuntu VM containing the Android development environment, including Android SDK, Android NDK using the Vagrant DevOps tool with Chef and shell-scripts.

This automated VM installation and configuration uses the DevOps tool [Vagrant](http://downloads.vagrantup.com/) which works with both VirtualBox (free) and VMware Fusion &amp; Workstation (paid plug-in) in addition to several [Community Chef Cookbooks](http://community.opscode.com/cookbooks).

Currently, it will provision an Android VM for development with the following specifications,

- Ubuntu Trusty64 VM
	- Memory size: 2048 MB
	- 2 vCPU
- Ubuntu Unity Desktop as the UI launched at startup
    - See the provision.sh section "Install a desktop for the Android graphical tooling" for other options)
- [Android SDK 20160407 (SDK r24.4.1 &amp; Eclipse)](http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz)
- [Android NDK r11c](http://dl.google.com/android/repository/android-ndk-r11c-linux-x86_64.zip)

## Install Vagrant

Note: Vagrant has a prerequisite of an installed and functioning version of one of the following virtualization products,

* [VMware Fusion (mac)](http://www.vmware.com/go/tryfusion) (Trial)
* [VMware Workstation (windows, linux)](http://www.vmware.com/products/workstation/workstation-evaluation) (Trial)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (Free)

1. Download and install the latest version of Vagrant for your OS from  [https://www.vagrantup.com/downloads.html](vagrantup.com/)

2. If using VMware, install the purchased VMware Provider Plug-in as mentioned in the documentation


## Install the Android VM

_Note: All the software needed is automatically downloaded as it is needed.  Several of the downloads are somewhat large.  Patience is a virtue while the automated installation is running._

1. From your android-vm directory,

		$ git submodule init
		$ git submodule update

2. Run the following to start Vagrant and kick-off the process to build an Android VM,
	
	For VirtualBox,
	
		$ vagrant up

	For VMware Fusion,
	
		$ vagrant up --provider=vmware_fusion 

	For VMware Workstation
	
		$ vagrant up --provider=vmware_workstation 

	_Note: As the Android VM build runs you will see various types of screen output from Vagrant, Chef and Shell scripts -- some of the dependency downloads and compilations require a bit of time.  Again, Patience is a virtue._
3. Once the Android VM build provisioning process is complete, run the following to login via SSH,

		$ vagrant ssh

### References

1. [Vagrant v2 documentation](http://docs.vagrantup.com/v2/getting-started/)
2. [http://www.vagrantbox.es/](http://www.vagrantbox.es/)
3. [Chef Cookbooks](http://community.opscode.com/cookbooks)


