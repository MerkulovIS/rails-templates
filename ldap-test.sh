#!/usr/bin/env bash

FOLDER="$HOME/RubymineProjects/ldap-template-test"
echo $FOLDER
cd $FOLDER && \
spring stop; rm -rf $(ls) && rm -rf .git && rm -rf .gitignore && \
rails new ~/RubymineProjects/ldap-template-test -d postgresql -M -C -T --skip-turbolinks -m ~/RubymineProjects/templates/ldap-template.rb && rails s