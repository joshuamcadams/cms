# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'hashicorp/precise64'

  config.vm.network :forwarded_port, guest: 3000, host: 3000
#config.vm.network "public_network", ip: "192.168.0.17"
#config.vm.network "public_network", ip: "192.168.0.17", bridge: 'en0: Wi-Fi (AirPort)'
  config.vm.provider 'virtualbox' do |v|
    v.memory = 2048
    v.cpus = 1
    v.gui = true
  end

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'config/ansible/playbooks/playbook.yml'
    ansible.limit = 'default'
  end
end
