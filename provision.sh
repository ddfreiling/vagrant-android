#!/usr/bin/env bash

echo "Installing System Tools..."
sudo apt-get update -y > /dev/null 2>&1
sudo apt-get install -y curl > /dev/null 2>&1
sudo apt-get install -y unzip > /dev/null 2>&1
sudo apt-get install -y libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 > /dev/null 2>&1
sudo apt-get update > /dev/null 2>&1
# sudo apt-get install apt-file && apt-file update > /dev/null 2>&1
sudo apt-get install -y python-software-properties > /dev/null 2>&1

# http://askubuntu.com/questions/147400/problems-with-eclipse-and-android-sdk
sudo apt-get install -y ia32-libs >/dev/null 2>&1

# Install a desktop for the Android graphical tooling, e.g. Eclipse
#echo "Installing Ubuntu Unity Desktop..."
#sudo aptitude install -y --without-recommends ubuntu-desktop >/dev/null 2>&1

# Or, the following desktop...
#echo "Installing Ubuntu Gnome Desktop..."
#sudo apt-get install -y ubuntu-desktop >/dev/null 2>&1

# Or, the following desktop...
#echo "Installing Ubuntu xfce lightweight desktop..."
#sudo apt-get install -y xubuntu-desktop >/dev/null 2>&1

# Or, the following desktop...
#echo "Installing Ubuntu KDE Desktop..."
#sudo apt-get install -y kubuntu-desktop >/dev/null 2>&1

# Install virtualbox additions
#sudo virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
#sudo sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config

sudo mkdir -p /usr/local/android

echo "Downloading & Installing Android SDK..."
cd /tmp
sudo wget -nv http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
sudo tar -zxf /tmp/android-sdk_r24.4.1-linux.tgz > /dev/null 2>&1
sudo mv /tmp/android-sdk-linux /usr/local/android/sdk
sudo rm -rf /tmp/android-sdk_r24.4.1-linux.tgz

echo "Downloading & Installing Android NDK..."
cd /tmp
sudo wget -nv http://dl.google.com/android/repository/android-ndk-r11c-linux-x86_64.zip
sudo unzip /tmp/android-ndk-r11c-linux-x86_64.zip >/dev/null 2>&1
sudo mv /tmp/android-ndk-r11c /usr/local/android/ndk
sudo rm -rf /tmp/android-ndk-r11c-linux-x86_64.zip

sudo chmod -R 755 /usr/local/android

sudo ln -s /usr/local/android/sdk/tools/android /usr/bin/android
sudo ln -s /usr/local/android/sdk/platform-tools/adb /usr/bin/adb

echo "Updating ANDROID_SDK, ANDROID_NDK & PATH variables..."
cd ~/
cat << End >> .profile
export ANDROID_HOME="/usr/local/android/sdk"
export ANDROID_SDK="/usr/local/android/sdk"
export ANDROID_NDK="/usr/local/android/ndk"
export PATH=$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH
End

source ~/.profile


echo "Updating Android SDK platform-tools"
echo "y" | sudo android update sdk --no-https --no-ui --filter platform-tools


echo "Adding USB device driver information..."
echo "For more detail see http://developer.android.com/tools/device.html"

sudo cp /vagrant/51-android.rules /etc/udev/rules.d
sudo chmod a+r /etc/udev/rules.d/51-android.rules

sudo service udev restart

echo " "
echo " "
echo " "
echo "[ Next Steps ]================================================================"
echo " "
echo "1. Manually setup a USB connection for your Android device to the new VM"
echo " "
echo "	If using VMware Fusion (for example, will be similar for VirtualBox):"
echo "  	1. Plug your android device hardware into the computers USB port"
echo "  	2. Open the 'Virtual Machine Library'"
echo "  	3. Select the VM, e.g. 'android-vm: default', right-click and choose"
echo " 		   'Settings...'"
echo "  	4. Select 'USB & Bluetooth', check the box next to your device and set"
echo " 		   the 'Plug In Action' to 'Connect to Linux'"
echo "  	5. Plug the device into the USB port and verify that it appears when "
echo "         you run 'lsusb' from the command line"
echo " "
echo "2. Your device should appear when running 'lsusb' enabling you to use adb, e.g."
echo " "
echo "		$ adb devices"
echo "			ex. output,"
echo " 		       List of devices attached"
echo " 		       007jbmi6          device"
echo " "
echo "		$ adb shell"
echo " 		    i.e. to log into the device (be sure to enable USB debugging on the device)"
echo " "
echo "See the included README.md for more detail on how to run and work with this VM."
echo " "
echo "[ Start your Ubuntu VM ]======================================================"
echo " "
echo "To start the VM, "
echo " 	To use with VirtualBox (free),"
echo " "
echo "			$ vagrant up"
echo " "
echo " 	To use with VMware Fusion (OS X) (requires paid plug-in),"
echo " "
echo "			$ vagrant up --provider=vmware_fusion"
echo " "
echo " 	To use VMware Workstation (Windows, Linux) (requires paid plug-in),"
echo " "
echo "			$ vagrant up --provider=vmware_workstation"

