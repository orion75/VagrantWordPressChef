require 'spec_helper'

describe 'apache::default' do
  context 'When all attributes are default, on Debian 12' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'debian', '11'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'actualiza los repositorios' do
      expect(chef_run).to run_execute('update-packages').with(command: 'sudo apt update')
    end
  
    it 'instala el paquete apache2' do
      expect(chef_run).to install_package('apache2')
    end
  
    it 'habilita y arranca el servicio apache2' do
      expect(chef_run).to enable_service('apache2')
      expect(chef_run).to start_service('apache2')
    end
  end

  context 'When all attributes are default, on Fedora 41' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'fedora', '32'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'actualiza los repositorios' do
      expect(chef_run).to run_execute('update-packages').with(command: 'sudo dnf -y update')
    end

    it 'instala el paquete httpd' do
      expect(chef_run).to install_package('httpd')
    end
  
    it 'habilita y arranca el servicio httpd' do
      expect(chef_run).to enable_service('httpd')
      expect(chef_run).to start_service('httpd')
    end
  end
end
