name             "application_nodejs"
maintainer       "David Radcliffe"
maintainer_email "radcliffe.david@gmail.com"
license          "MIT"
description      "Deploys and configures Node.js applications"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

depends "application", "~> 3.0"
depends "runit", "~> 1.0"
depends "nodejs"
depends "npm"
