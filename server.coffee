
#!
# * See LICENSE.txt for full copyright notice.
# *
# * Copyright (C) 2014, 2015 Berend van Berkum (.mpe) <dev@dotmpe.com>
# * GNU GPL v3
#

# Enable LiveScript
#require "LiveScript"

# customized Express loader
nodelib = require 'nodelib'
nodelib.module.init( __dirname )

# Init express-seed base app
core = nodelib.module.load_core( 'src/dotmpe/express-seed' )
core.configure()

# Load additional project modules
core.load_modules()

# Start webserver
core.start()

