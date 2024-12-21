# Atributos específicos de plataforma
apache_package = case node['platform']
      when 'debian'
        'apache2'
      when 'fedora'
        'httpd'
      end

apache_service = case node['platform']
      when 'debian'
        'apache2'
      when 'fedora'
        'httpd'
      end

update_command = case node['platform']
      when 'debian'
        'sudo apt update'
      when 'fedora'
        'sudo dnf -y update'
      end

# Actualizar los repositorios de paquetes
execute "update-packages" do
  command update_command
end

# Instalar Apache
package apache_package do
  action :install
end

# Habilitar y arrancar el servicio Apache
service apache_service do
  action [:enable, :start]
end
