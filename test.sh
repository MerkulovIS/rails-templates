#!/usr/bin/env bash

FOLDER="$HOME/RubymineProjects/template-test"
echo $FOLDER
cd $FOLDER && \
spring stop; rm -rf $(ls) && rm -rf .git && rm -rf .gitignore && \
rails new ~/RubymineProjects/template-test -d postgresql -M -C -T --skip-turbolinks -m ~/RubymineProjects/templates/bootstrap-template.rb && rails s