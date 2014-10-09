# vi: set ft=ruby

$script = <<SCRIPT
#!/usr/bin/env bash


apt-get update
apt-get install -y python-dev gcc python-pip
apt-get install -y vim git ack-grep

pip install virtualenv

rm -rf env
virtualenv env
source env/bin/activate
pip install ansible
pip install awscli
echo "source env/bin/activate" > ~vagrant/.bash_profile
echo "cd /vagrant" >> ~vagrant/.bash_profile


#mkdir vyos
#cd vyos
#git clone https://github.com/hydrajump/vyos-build-ami

#mkdir /files
#chown ec2-user /files


SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs-debian-607-x64-vbox4210-nocm"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-607-x64-vbox4210-nocm.box"

  config.vm.provision :file, source: '~/.gitconfig', destination: '/home/vagrant/.gitconfig' if File.exist?(ENV['HOME'] + '/.gitconfig')
  config.vm.provision :file, source: '~/.vimrc', destination: '/home/vagrant/.vimrc' if File.exist?(ENV['HOME'] + '/.vimrc')
  config.vm.provision "shell", inline: $script
end

