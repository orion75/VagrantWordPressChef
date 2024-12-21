#!/bin/bash

cd cookbooks/mariadb
chef install


kitchen destroy
kitchen list

# kitchen converge
# kitchen list

# kitchen verify
# kitchen list

# kitchen destroy
# kitchen list
cd ../../