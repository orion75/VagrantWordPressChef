#
# Cookbook:: wordpress
# Spec:: default
#
# Copyright:: 2024, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'wordpress::default' do
  context 'When all attributes are default, on Debian 12' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'debian', '11'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    php_packages = %w(php8.2 php-mysql php-curl php-imagick php-intl php-mbstring php-xml php-zip)
    it 'instalacion packages de Php' do
      expect(chef_run).to install_package(php_packages)
    end

    it 'descarga WordPress desde el enlace oficial' do
      expect(chef_run).to create_remote_file('/tmp/latest.tar.gz').with(
        source: 'https://wordpress.org/latest.tar.gz',
        action: [:create]
      )
    end
    
  end

  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'fedora', '32'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    php_packages = %w(php php-mysqlnd php-curl php-imagick php-intl php-mbstring php-xml php-zip)
    it 'instalacion packages de Php' do
      expect(chef_run).to install_package(php_packages)
    end

    it 'descarga WordPress desde el enlace oficial' do
      expect(chef_run).to create_remote_file('/tmp/latest.tar.gz').with(
        source: 'https://wordpress.org/latest.tar.gz',
        action: [:create]
      )
    end
  end
end
