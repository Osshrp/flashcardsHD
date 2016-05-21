# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "package.box"
  
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.synced_folder "../ruby/Projects/flashcardsHD", "/home/vagrant/projects/flashcardsHD", create: true

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    yum install git -y
    echo "Installing Postgresql"
    yum install postgresql postgresql-devel postgresql-server -y
    yum install epel-release -y
    yum install nodejs -y
  SHELL
  
  $script = %{
  echo 'Installing RVM with latest ruby'
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  curl -sSL https://get.rvm.io | bash -s stable --ruby
  source /home/vagrant/.rvm/scripts/rvm
  cd /home/vagrant/projects/flashcardsHD
  gem install bundler
  bundle install
  rails server -b 0.0.0.0
  }

  config.vm.provision "shell", inline: $script, privileged: false
  
  

end
