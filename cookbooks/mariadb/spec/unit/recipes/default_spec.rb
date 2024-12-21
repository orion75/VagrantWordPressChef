#
# Cookbook:: mariadb
# Spec:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mariadb::default' do

  before do
    # Simula que la base de datos "wordpress" no existe
    stub_command("sudo mysql -e 'SHOW DATABASES;' | grep wordpress").and_return(false)
  end



  context 'When all attributes are default, on Debian 12' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'debian', '11'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'instala la dependencia libmariadb-dev' do
      expect(chef_run).to install_package('libmariadb-dev')
    end

    it 'instala el paquete mariadb-server' do
      expect(chef_run).to install_package('mariadb-server')
    end

    it 'habilita y arranca el servicio mariadb ' do
      expect(chef_run).to enable_service('mariadb')
      expect(chef_run).to start_service('mariadb')
    end

    it 'crea la base de datos wordpress si no existe' do
      expect(chef_run).to run_execute('secure-installation').with(
        command: /CREATE DATABASE wordpress;/
      )
    end

  end

  context 'When all attributes are default, on Fedora 41' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'fedora', '32'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'instala la dependencia mariadb-devel' do
      expect(chef_run).to install_package('mariadb-devel')
    end

    it 'instala el paquete mariadb-server' do
      expect(chef_run).to install_package('mariadb-server')
    end

    it 'habilita y arranca el servicio mariadb ' do
      expect(chef_run).to enable_service('mariadb')
      expect(chef_run).to start_service('mariadb')
    end

    it 'crea la base de datos wordpress si no existe' do
      expect(chef_run).to run_execute('secure-installation').with(
        command: /CREATE DATABASE wordpress;/
      )
    end
  end
end
