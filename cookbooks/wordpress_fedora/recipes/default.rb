# Instalar Apache y PHP en Fedora
package %w(php php-mysqlnd php-curl php-imagick php-intl php-mbstring php-xml php-zip) do
  action :install
end

# Descargar y configurar WordPress
remote_file '/tmp/latest.tar.gz' do
  source 'https://wordpress.org/latest.tar.gz'
  action :create
end

bash 'extract_wordpress' do
  code <<-EOH
    tar -xzf /tmp/latest.tar.gz -C /var/www
    chown -R apache:apache /var/www/wordpress
  EOH
  not_if { ::File.exist?('/var/www/wordpress') }
end

# Configurar el archivo wp-config.php
template '/var/www/wordpress/wp-config.php' do
  source 'wp-config.conf.erb'
  variables(
    db_name: node['wordpress']['db_name'],
    db_user: node['wordpress']['db_user'],
    db_password: node['wordpress']['db_password']
  )
end

# Configurar el archivo de host virtual de Apache
template '/etc/httpd/conf.d/wordpress.conf' do
  source 'wordpress.conf.erb'
  variables(
    document_root: '/var/www/wordpress'
  )
end

# Reiniciar Apache para aplicar cambios
service 'httpd' do
  action :restart
end
