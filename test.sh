#!/usr/bin/env bash

FOLDER="$HOME/RubymineProjects/template-test"
echo $FOLDER
cd $FOLDER && \
spring stop; rm -rf $(ls) && rm -rf .git && rm -rf .gitignore && \
rails new ~/RubymineProjects/template-test -d postgresql -M -C -T --skip-turbolinks -m ~/RubymineProjects/templates/bootstrap-template.rb && rails s


# rails new . -d postgresql -M -T --skip-turbolinks -m ~/RubymineProjects/templates/bootstrap-template.rb

# rails new . -d postgresql -M -C -T --skip-turbolinks -m ~/RubymineProjects/templates/ldap-template.rb

# spring stop; rm -rf $(ls) && rm -rf .git && rm -rf .gitignore && \

rails new . -d postgresql -T -m ~/RubymineProjects/templates/bootstrap-template.rb
