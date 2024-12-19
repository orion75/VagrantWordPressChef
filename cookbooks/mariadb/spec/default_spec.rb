require 'chefspec'

describe 'mariadb_fedora::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'fedora', version: '38').converge(described_recipe) }

  it 'instala el paquete mariadb-server' do
    expect(chef_run).to install_package('mariadb-server')
  end

  it 'habilita y arranca el servicio mariadb' do
    expect(chef_run).to enable_service('mariadb')
    expect(chef_run).to start_service('mariadb')
  end

  it 'ejecuta un comando para configurar MariaDB' do
    expect(chef_run).to run_execute('secure-installation')
  end
end
