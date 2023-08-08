#!/bin/bash

echo "======================= CONFIGURATION ======================"
echo "| Follow the steps to configure your template              |"
echo "============================================================"
read -p "Plugin Name (Ex.: Leaflet.mouseCoordinate): Leaflet." plugin_name

sed -i "s/myplugin/${plugin_name,,}/g" webpack.*

npm_plugin_name=$(echo $plugin_name | sed "s/\./-/g" | sed "s/\s//g")

sed -i "s/myplugin/${npm_plugin_name,,}/g" package.json
sed -i "s/myplugin/${plugin_name,,}/g" index.html

mv src/leaflet.myplugin.js src/"leaflet.${plugin_name,,}.js"
mv src/leaflet.myplugin.css src/"leaflet.${plugin_name,,}.css"

leaflet_namespace=$(echo "${plugin_name^}" | sed "s/[\.-]//g")

sed -i "s/mypluginControl/${leaflet_namespace}/g" src/"leaflet.${plugin_name,,}.js"
sed -i "s/mypluginConstructor/${leaflet_namespace,,}/g" src/"leaflet.${plugin_name,,}.js"
sed -i "s/myplugin\.css/leaflet.${plugin_name,,}.css/g" src/"leaflet.${plugin_name,,}.js"

read -p "Plugin Description: " description
sed -i "s/<template-description>/${description}/g" package.json

read -p "Author Name: " author
sed -i "s/<template-author>/${author}/g" package.json

read -p "GitHub Repository URL: " repository
escaped_repository=$(echo $repository | sed 's/\//\\\//g')

sed -i "s/<template-github>/${escaped_repository}/g" package.json

echo
echo "##############################################################"
echo "# Obs.: You Have to modify keywords manually in package.json #"
echo "##############################################################"
echo

echo "UPDATING LICENSE..."
sed -i "s/<COPYRIGHT HOLDER>/${author}/g" LICENSE
year=$(date +%Y)
sed -i "s/<YEAR>/${year}/g" LICENSE
echo "LICENSE UPDATED!"
echo

echo "======================= INSTALL PKGS =============================="
echo "| Installing Latest Dependencies and Development Dependencies     |"
echo "==================================================================="
echo
echo "Installing @Latest Dev packages ..."

npm install --save-dev css-loader@latest eslint@latest eslint-config-airbnb@latest eslint-plugin-import@latest mini-css-extract-plugin@latest webpack@latest webpack-cli@latest

echo "**************************************************"
echo "*                 Dev packages OK                *"
echo "**************************************************"
echo
echo "Installing Latest Leaflet Package ..."

npm install --save leaflet@latest

echo "**************************************************"
echo "*                    All done!                   *"
echo "**************************************************"
