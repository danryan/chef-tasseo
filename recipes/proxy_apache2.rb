#
# Cookbook Name:: tasseo
# Recipe:: proxy_apache2
#
# Author:: Joseph Anthony Pasquale Holsten <joseph@josephholsten.com>
#
# Copyright 2011, Joseph Anthony Pasquale Holsten
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apache2"

apache_module "proxy"
apache_module "proxy_http"
apache_module "vhost_alias"
apache_module "headers"

template "#{node[:apache][:dir]}/sites-available/tasseo" do
  source      "apache_vhost.erb"
  owner       'root'
  group       'root'
  mode        '0644'

  if File.exists?("#{node[:apache][:dir]}/sites-enabled/tasseo")
    notifies  :restart, 'service[apache2]'
  end
end

apache_site "000-default" do
  enable  false
end

apache_site "tasseo" do
  enable true
end
