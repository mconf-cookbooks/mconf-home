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
directory node['mconf-home']['deploy_to'] do
  owner node['mconf-home']['user']
  group node['mconf-home']['app_group']
  mode '0755'
  recursive true
  action :create
end


apache_module 'rewrite'

%w{default default-ssl 000-default}.each do |site|
  apache_site site do
    enable false
  end
end

rewrites = []
if Chef::DataBag.list.key?('apache2_rewrites')
  items = data_bag('apache2_rewrites')
  items.each do |item|
    rewrites << data_bag_item('apache2_rewrites', item)
  end
end

# Apache website configuration
# Note: can't use web_app because it doesn't take variables
template "#{node['apache']['dir']}/sites-available/mconf-home.conf" do
  source "apache-site.conf.erb"
  mode 00644
  owner 'root'
  group 'root'
  variables rewrites: rewrites
  notifies :restart, "service[apache2]", :delayed
end
apache_site 'mconf-home' do
  action :enable
  notifies :restart, "service[apache2]", :delayed
end

# To validate our Apache configurations
execute 'validate apache' do
  command 'apache2ctl configtest'
end
