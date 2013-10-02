#
# Author:: David Radcliffe <radcliffe.david@gmail.com>
# Cookbook Name:: application_nodejs
# Provider:: nodejs
#
# Copyright:: 2013, David Radcliffe <radcliffe.david@gmail.com>
#

include Chef::Mixin::LanguageIncludeRecipe

action :before_compile do

  include_recipe 'nodejs'

end

action :before_deploy do

  new_resource.environment['NODE_ENV'] = new_resource.environment_name
  
  new_resource.packages.each do |pkg,ver|
    npm_package pkg do
      action :install
      version ver if ver && ver.length > 0
    end
  end

end

action :before_migrate do

  if new_resource.npm_symlink
    Chef::Log.info "Symlinking node_modules"
    directory "#{new_resource.path}/shared/node_modules" do
      owner new_resource.owner
      group new_resource.group
      mode '0755'
    end
    directory "#{new_resource.release_path}/node_modules" do
      owner new_resource.owner
      group new_resource.group
      mode '0755'
    end
    link "#{new_resource.release_path}/node_modules" do
      to "#{new_resource.path}/shared/node_modules"
    end
  end

  if new_resource.npm_install
    Chef::Log.info "Running npm install"
    execute "npm install" do
      cwd new_resource.release_path
      user new_resource.owner
      environment new_resource.environment
    end
  end

  if new_resource.npm_rebuild
    Chef::Log.info "Running npm rebuild"
    execute "npm rebuild" do
      cwd new_resource.release_path
      user new_resource.owner
      environment new_resource.environment
    end
  end

end

action :before_symlink do
end

action :before_restart do

  runit_service new_resource.name do
    run_template_name 'nodejs'
    log_template_name 'nodejs'
    owner new_resource.owner if new_resource.owner
    group new_resource.group if new_resource.group
    cookbook 'application_nodejs'
    env new_resource.environment unless new_resource.environment.empty?
    options(
      :app => new_resource
    )
  end

end

action :after_restart do
end
