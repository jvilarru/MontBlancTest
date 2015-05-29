#!/bin/bash
RELEASE=$(lsb_release -sc)
wget https://apt.puppetlabs.com/puppetlabs-release-${RELEASE}.deb -O puppetlabs.deb
sudo dpkg -i puppetlabs.deb
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y puppet git 
if [ "$1" == "--devel" ]; then
	sudo apt-get install -y vim vim-puppet
fi
rm puppetlabs.deb
git clone https://github.com/uriviba/MontBlancTest.git Mont-Blanc
sudo puppet apply Mont-Blanc/puppet/manifests --modulepath=Mont-Blanc/puppet/modules --test