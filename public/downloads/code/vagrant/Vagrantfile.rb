Vagrant.configure(2) do |config|
  config.vm.box = "dev-env"
  config.vm.hostname = "development.puppetlabs.vm"
  config.vm.network "private_network", ip: "172.31.0.202"
  config.vm.network "forwarded_port", guest: 80, host: 8084
  config.vm.provision :shell, :path => "centos_7_x.sh"

  # Puppet shared folder
  config.vm.synced_folder "puppet", "/puppet"

  #puppet provision setup
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file = "site.pp"
  end
end
