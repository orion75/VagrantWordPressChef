# Actualizar los paquetes en Fedora
execute "update-dnf" do
  command "sudo dnf -y update"
end

# Instalar Apache en Fedora
package %w(httpd) do
  action :install
end

# Habilitar y arrancar Apache en Fedora
service "httpd" do
  action [:enable, :start]
end