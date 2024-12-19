# Atributos específicos de plataforma
web_user = case node['platform']
      when 'debian'
        'www-data'
      when 'fedora'
        'apache'
      end

apache_service = case node['platform']
      when 'debian'
        'apache2'
      when 'fedora'
        'httpd'
      end

php_packages = case node['platform']
    when 'debian'
      %w(php8.2 php-mysql php-curl php-imagick php-intl php-mbstring php-xml php-zip)
    when 'fedora'
      %w(php php-mysqlnd php-curl php-imagick php-intl php-mbstring php-xml php-zip)
    end


# Instalar Apache y PHP
package php_packages do
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
    chown -R #{web_user}:#{web_user} /var/www/wordpress
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

# Configuración específica para cada plataforma
case node['platform']
when 'debian'
  template '/etc/apache2/sites-available/000-default.conf' do
    source '000-default.conf.erb'
  end

  # Reiniciar el servicio de Apache
  service apache_service do
    action :restart
  end
when 'fedora'
  template '/etc/httpd/conf.d/wordpress.conf' do
    source 'wordpress.conf.erb'
  end

  # Habilitar y arrancar Apache en Fedora
  service "httpd" do
    action [:enable, :start]
  end
end


