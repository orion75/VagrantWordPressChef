#
# Cookbook:: mariadb
# Recipe:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.
# Atributos específicos de plataforma
mariadb_dev_package = case node['platform']
                when 'debian'
                  'libmariadb-dev'
                when 'fedora'
                  'mariadb-devel'
                else
                    ''
                end

# Actualizar repositorios de paquetes
case node['platform']
                when 'debian'
                    execute "update-apt" do
                        command "sudo apt update"
                    end
                when 'fedora'
                    execute "update-dnf" do
                        command "sudo dnf -y update"
                    end
                else
                    ''
                end

# Instalar dependencias específicas de MariaDB
package [mariadb_dev_package] do
    action :install
end

# Instalar MariaDB
package %w(mariadb-server) do
    action :install
end

# Iniciar y habilitar el servicio MariaDB
service "mariadb" do
    action [:enable, :start]
end

# Configurar MariaDB para WordPress
execute "secure-installation" do
    command <<-EOF
        sudo mysql -e "CREATE DATABASE wordpress;"
        sudo mysql -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';"
        sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';"
        sudo mysql -e "FLUSH PRIVILEGES;"
    EOF
    not_if "sudo mysql -e 'SHOW DATABASES;' | grep wordpress"
    # action :run
end

# Restaurar Backup
execute "restore_mysql_database" do
    command <<-EOF
        sudo mysql wordpress < /vagrant/wordpress_backup.sql;
        EOF
    only_if { ::File.exist?("/vagrant/wordpress_backup.sql") }
end
