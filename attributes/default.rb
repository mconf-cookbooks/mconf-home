#
# This file is part of the Mconf project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

default['mconf-home']['user']           = node['mconf']['user'] || 'mconf'
default['mconf-home']['app_group']      = node['mconf']['app_group'] || 'www-data'
default['mconf-home']['domain']         = '192.168.0.100'
default['mconf-home']['deploy_to']      = '/var/www/mconf-home'
default['mconf-home']['deploy_to_full'] = '/var/www/mconf-home/current'
default['mconf-home']['remove_www']     = true
