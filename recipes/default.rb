#
# Cookbook Name:: mconf-home
# Recipe:: default
# Author:: Leonardo Crauss Daronco (<daronco@mconf.org>)
#
# This file is part of the Mconf project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

include_recipe 'build-essential'

include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "apache2"
include_recipe "apache2::mod_php5"


# Create the app directory
# (Just the directory, capistrano does the rest)
directory node['mconf-home']['deploy_to_full'] do
  owner node['mconf']['user']
  group node['mconf']['app_group']
  mode '0755'
  recursive true
  action :create
end


apache_module 'rewrite'
# apache_module 'xsendfile'

%w{default default-ssl 000-default}.each do |site|
  apache_site site do
    enable false
  end
end

# To validate our Apache configurations
execute 'validate apache' do
  command 'apache2ctl configtest'
end
