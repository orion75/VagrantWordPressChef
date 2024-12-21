#!/bin/bash

# vagrant ssh test -c "cd /vagrant/cookbooks/apache && chef exec rspec --format=documentation" 
# vagrant ssh test -c "cd /vagrant/cookbooks/mariadb && chef exec rspec --format=documentation" 
# vagrant ssh test -c "cd /vagrant/cookbooks/wordpress && chef exec rspec --format=documentation" 

cd cookbooks/apache
chef exec rspec --format=documentation
cd ../../

cd cookbooks/mariadb
chef exec rspec --format=documentation
cd ../../

cd cookbooks/wordpress
chef exec rspec --format=documentation
cd ../../
