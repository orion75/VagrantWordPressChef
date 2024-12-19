execute "update-apt" do
  command "sudo apt update"
end

package %w(libmariadb-dev) do
  action :install
end

# Instalar MariaDB
package %w(mariadb-server) do
  action :install
end

# Iniciar el servicio MariaDB
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
end

# Restablecer Backup
execute "restore_mysql_database" do
  command <<-EOF
    sudo mysql wordpress < /vagrant/wordpress_backup.sql;
  EOF
  only_if { ::File.exist?("/vagrant/wordpress_backup.sql") }
end