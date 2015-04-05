NodeJS Socket.IO Seed
=====================
Seed project for NodeJS+Express.

Working
  - Basic structure and configuration for extendible Express app.
    No specs are written except the running code w/ comments.

Wanted
  - View-Controller metadata TODO: spec
  - Schema metadata, migration, validation at structure and datatype level.

See below for details, and `Branch docs`_ for work in process.

:FIXME: set-up master again to something without experiments
:XXX: After x-nodejs-socketio-ng-seed-mpe, started new repo for clean set-up. Should finally ditch that.
:FIXME: messy client build setup, start cleaning up styles into stylus files
:TODO: angular client integration either goes or does something together with express-client
:TODO: loose the src/dotmpe too, move stuff to lib/
:XXX: there aren't any tests

Tree docs
---------
config
  - any local settings, in static or script format. Should provide examples and
    defaults later.

public
  - the www-data build directory, mounted at config.urls.base

app
  - deprecated, moving to src/node/dotmpe

lib
  TODO

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

  f_clientbuild [*]_
    - Want to build lazy-loading, fully packaged client. 
      Need build-system, code and style compilers.
    - Testing Grunt.
    - Got some require.js build running which I like.
    - Removed modulr but may want to do lazy eval later again.
    - Started express-client to experiment with metadata driven pages,
      and to think some specific types resources display and navigate.

  f_ext
    - Get an extension framework going at the backend with plugin modules.

  f_orm
    - Added Knex ORM, and WarehouseJS for Backbone REST access to ORM.
    - Play with backbone client. Look at MarionetteJS maybe.

  feature
    - Merging all features with exmaple modules here.
      To keep master clean. Should hand-pick generic changes to master.


----

.. [*] Current branch.

