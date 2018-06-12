#!/bin/sh -e

vagrant up
vagrant ssh --command "cd /vagrant && script/vagrant/vagrant.sh"
script/vagrant/update-hosts.sh
