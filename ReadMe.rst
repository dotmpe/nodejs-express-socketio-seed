NodeJS Socket.IO Seed
=====================
Seed project for NodeJS+Express.

XXX After x-nodejs-socketio-ng-seed-mpe, started new repo for clean set-up.

Going to write some examples, demos, and hopefully work towards some common
structure and seed branches.

Work in progress
  Modulr 
    - fix configuration
  - Initialize menu for loaded components.

Wanted
  - View-Controller metadata
  - Schema metadata, migration, validation at structure and datatype level.

Tree docs
---------
app
  - deprecated, moving to src/node/dotmpe
 
src
  node
    - local NodeJS code

    dotmpe/express-seed
      - bootstrap for Express. 
        Beginning of some Express-MVC framwork
        with other modules in dotmpe/

    dotmpe/x-bookmarks
      - re-using some old code to test Express-MVC
        see also project:node-htdocs

    dotmpe/project
      - TODO Express-MVC module to deal with projects

    dotmpe/npm-project
      - TODO Express-MVC module to interact with other npm projects


Branch docs
-----------
master
  - Initial project structure, documentation.

  f_bootstrap
    - Going to dust off my own Du stylesheets and get bootstrap components and
      layout into the picture.

  f_clientbuild
    - Want to build lazy-loading, fully packaged client. 
      Need build-system, code and style compilers.
    - Testing Grunt.
    - Got some require.js build running which I like.
    - Removed modulr but may want to do lazy eval later again.

  f_ext
    - Try to get an extension framework going at the backend with plugin modules.

  f_orm
    - Added Knex ORM, and WarehouseJS for Backbone REST access to ORM.
    - Play with backbone client. Look at MarionetteJS

  feature
    - Merging all features with exmaple modules here.
      To keep master clean. Should hand-pick generic changes to master.

