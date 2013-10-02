#
# Author:: David Radcliffe <radcliffe.david@gmail.com>
# Cookbook Name:: application_nodejs
# Resource:: nodejs
#
# Copyright:: 2013, David Radcliffe <radcliffe.david@gmail.com>
#

include ApplicationCookbook::ResourceBase

attribute :npm_install, :kind_of => [TrueClass, FalseClass], :default => false
attribute :npm_symlink, :kind_of => [TrueClass, FalseClass], :default => false
attribute :npm_rebuild, :kind_of => [TrueClass, FalseClass], :default => true
attribute :packages, :kind_of => [Array, Hash], :default => []
attribute :command, :kind_of => String, :default => 'node'
attribute :script, :kind_of => String, :required => true
