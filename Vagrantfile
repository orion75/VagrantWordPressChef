Vagrant.configure("2") do |config|

    # Configuración para debian
    config.vm.define "debian_vm" do |debian|
        # Configura el sistema operativo base. Aquí usamos la caja oficial de Debian 12.
        debian.vm.box = "debian/bookworm64"
        debian.vm.hostname = "wordpress-debian"
        debian.vm.network "private_network", ip: "192.168.56.200"
        # Configura la cantidad de memoria RAM y los CPUs asignados a la VM.
        debian.vm.provider "virtualbox" do |vb|
            vb.name = "Debian"  # Nombre de la máquina en VirtualBox.
            vb.memory = "1024"  # Asigna 1 GB de RAM.
            vb.cpus = 2         # Asigna 2 CPUs.
        end
        
        debian.vm.provision "chef_solo" do |chef|
            chef.cookbooks_path = "cookbooks"
            chef.add_recipe "apache_debian"
            chef.add_recipe "mariadb_debian"
            chef.add_recipe "wordpress_debian"
            chef.arguments = "--chef-license accept"
        end
    end
  

    # Configuración para fedora
    config.vm.define "fedora_vm" do |fedora|
        fedora.vm.box = "fedora/41-cloud-base"
        fedora.vm.hostname = "wordpress-fedora"
        fedora.vm.network "private_network", ip: "192.168.56.100"
        # Configura la cantidad de memoria RAM y los CPUs asignados a la VM.
        fedora.vm.provider "virtualbox" do |vb|
            vb.name = "fedora"  # Nombre de la máquina en VirtualBox.
            vb.memory = "1024"  # Asigna 1 GB de RAM.
            vb.cpus = 2         # Asigna 2 CPUs.
        end
        
        fedora.vm.provision "chef_solo" do |chef|
            chef.add_recipe "apache_fedora"
            chef.add_recipe "mariadb_fedora"
            chef.add_recipe "wordpress_fedora"
            chef.arguments = "--chef-license accept"
        end
    end
  
end