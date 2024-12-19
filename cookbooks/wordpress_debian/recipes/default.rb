# Instalar Apache y PHP
package %w(php8.2 php-mysql php-curl php-imagick php-intl php-mbstring php-xml php-zip) do
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
    chown -R www-data:www-data /var/www/wordpress
    EOH
  not_if { ::File.exist?('/var/www/wordpress') }
end
  
# Configurar el archivo wp-config.php
template '/var/www/wordpress/wp-config.php' do
  source 'wordpress.conf.erb'
  variables(
    db_name: node['wordpress']['db_name'],
    db_user: node['wordpress']['db_user'],
    db_password: node['wordpress']['db_password']
  )
end

template '/etc/apache2/sites-available/000-default.conf' do
  source '000-default.conf.erb'
end

service 'apache2' do
  action :restart
end