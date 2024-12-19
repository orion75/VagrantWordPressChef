execute "update-apt" do
  command "sudo apt update"
end

# Instalar Apache y PHP
package %w(apache2) do
  action :install
end
  
# Habilitar y arrancar Apache
service "apache2" do
  action [:enable, :start]
end
