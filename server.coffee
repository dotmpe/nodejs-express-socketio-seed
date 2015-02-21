
#!
# * See LICENSE.txt for full copyright notice.
# *
# * Copyright (C) 2014, 2015 Berend van Berkum (.mpe) <dev@dotmpe.com>
# * GNU GPL v3
# 

# Enable LiveScript 
require "LiveScript"

# customized Express loader
module_mpe = require './src/node/dotmpe/module'

module_mpe.init( __dirname )

# Init express-seed base app
core = module_mpe.load_core( 'src/node/dotmpe/express-seed' )
core.configure()

core.load_modules()

# Load core component of the app
#core = require("./config/routes") app, config
# Add configured components
#require("./config/modules") app, core 

core.start()

