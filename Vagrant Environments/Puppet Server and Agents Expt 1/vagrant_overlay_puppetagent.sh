
if [ $(which apt-get) ]; then
	sudo curl -s -o puppet-release-xenial.deb https://apt.puppetlabs.com/puppet-release-xenial.deb
	sudo dpkg -i puppet-release-xenial.deb
	sudo apt-get -qq update
	sudo apt-get -y -qq install puppet
	sudo puppet agent --enable
fi

if [ $(which yum) ]; then
	sudo yum -y install https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
	sudo yum -y update
	sudo yum -y install puppet vim
	sudo puppet agent --enable
	sudo rm -f puppetlabs-release-el-7.noarch.rpm
fi
