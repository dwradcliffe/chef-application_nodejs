Description
===========

This cookbook is designed to be able to describe and deploy Node.js web applications.

Note that this cookbook provides the Node.js-specific bindings for the `application` cookbook; you will find general documentation in that cookbook.

Requirements
============

Chef 0.10.0 or higher required (for Chef environment use).

The following Opscode cookbooks are dependencies:

* application
* runit
* nodejs

Resources/Providers
==========

The LWRPs provided by this cookbook are not meant to be used by themselves; make sure you are familiar with the `application` cookbook before proceeding.

nodejs
------

The `nodejs` sub-resource LWRP deals with deploying Node.js webapps from an SCM repository. It uses the `deploy_revision` LWRP to perform the bulk of its tasks, and many concepts and parameters map directly to it. Check the documentation for `deploy_revision` for more information.

For applications that use NPM, there are several options for installing modules. The preferred pattern is to keep all package dependancies in the repository and run `npm rebuild` to rebuild any modules that need to be compiled. This is the default action of this resource. For more information on this pattern, visit http://www.futurealoof.com/posts/nodemodules-in-git.html.

This provider also initializes a runit service for this application.


### Attribute Parameters

- npm_install: if true, will run `npm install`. Defaults to false.
- npm_symlink: if true, will symlink the node_modules directory to the shared directory. Defaults to false.
- npm_rebuild: if true, will run `npm rebuild`. Defaults to true.
- packages: list of npm packages to install.
- command: The command to execute when starting the app.  Useful for specifing alternate commands such as `coffee`.  Defaults to `node`.
- script: The script to run when starting the app. This is required.

Usage
=====

A sample application:

    application "my-app" do
      path "/usr/local/www/my-app"

      nodejs do
        script "app.js"
      end

    end

Or an application that uses CoffeeScript:

    application "my-app" do
      path "/usr/local/www/my-app"

      nodejs do
        packages "coffee-script" => "1.6.3"
        command "coffee"
        script "app.coffee"
      end

    end

License and Author
==================

Author:: [David Radcliffe](https://github.com/dwradcliffe)

License:: [MIT](https://github.com/dwradcliffe/chef-application_nodejs/blob/master/LICENSE)
