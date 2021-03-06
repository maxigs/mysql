#
# Cookbook Name:: mysql
# Recipe:: ruby
#
# Author:: Jesse Howarth (<him@jessehowarth.com>)
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2008-2012, Opscode, Inc.
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

execute "apt-get update" do
  ignore_failure true
  action :nothing
end.run_action(:run) if node['platform_family'] == "debian"

node.set['build_essential']['compiletime'] = true
include_recipe "build-essential"
include_recipe "mysql::client"

node['mysql']['client']['packages'].each do |mysql_pack|
  resources("package[#{mysql_pack}]").run_action(:install)
end

b = package "build-essential" do
  action :nothing
end

b.run_action(:install)

r = gem_package "mysql" do
  action :nothing
end

chef_gem 'mysql'
