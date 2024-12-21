# InSpec test for recipe mariadb::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

# unless os.windows?
#   # This is an example test, replace with your own test.
#   describe user('root'), :skip do
#     it { should exist }
#   end
# end

# # This is an example test, replace it with your own test.
# describe port(80), :skip do
#   it { should_not be_listening }
# end





# Verifica que el paquete MariaDB esté instalado
describe port(3306) do
    it { should be_listening }
end


# Verifica que el paquete MariaDB esté instalado
describe package('mariadb-server') do
  it { should be_installed }
end

# Verifica que el servicio MariaDB esté habilitado y en ejecución
describe service('mariadb') do
  it { should be_enabled }
  it { should be_running }
end

# Verifica que la base de datos "wordpress" existe
describe command("sudo mysql -e 'SHOW DATABASES;'") do
  its('stdout') { should match /wordpress/ }
end

if os[:family] == 'debian'
  # Verifica el archivo en Debian
  describe package('libmariadb-dev') do
    it { should be_installed }
  end
  describe file('/etc/apache2/sites-enabled/000-default.conf') do
    it { should exist }
  end
elsif os[:family] == 'fedora'
  # Verifica el archivo en Fedora
  describe package('mariadb-devel') do
    it { should be_installed }
  end
end