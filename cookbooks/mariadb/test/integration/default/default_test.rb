
# Validaciones para Apache2
if os[:family] == 'debian'
  describe package('apache2') do
    it { should be_installed }
  end
  describe file('/etc/apache2/sites-enabled/000-default.conf') do
    it { should exist }
  end
  describe service('apache2') do
    it { should be_enabled }
    it { should be_running }
  end
elsif os[:family] == 'fedora'
  describe package('httpd') do
    it { should be_installed }
  end
  describe file('/etc/httpd/conf.d/welcome.conf') do
    it { should exist }
  end
  describe service('httpd') do
    it { should be_enabled }
    it { should be_running }
  end
end

describe port(80) do
  it { should be_listening }
end







# Validaciones para MariaDb


if os[:family] == 'debian'
  describe package('libmariadb-dev') do
    it { should be_installed }
  end
  
elsif os[:family] == 'fedora'
  describe package('mariadb-devel') do
    it { should be_installed }
  end
end

describe package('mariadb-server') do
  it { should be_installed }
end

describe command("sudo mysql -e 'SHOW DATABASES;'") do
  its('stdout') { should match /wordpress/ }
end

describe service('mariadb') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3306) do
  it { should be_listening }
end