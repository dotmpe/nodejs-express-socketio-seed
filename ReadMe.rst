NodeJS Socket.IO Seed
=====================
:version: 0.0.2
:package status:

  .. image:: https://gemnasium.com/dotmpe/nodejs-express-socketio-seed.png
     :target: https://gemnasium.com/dotmpe/nodejs-express-socketio-seed
     :alt: Dependencies

  .. image:: https://secure.travis-ci.org/dotmpe/nodejs-express-socketio-seed.png
     :target: https://travis-ci.org/dotmpe/nodejs-express-socketio-seed
     :alt: Build

:repository:

  .. image:: https://badge.fury.io/gh/dotmpe%2Fnodejs-express-socketio-seed.png
     :target: http://badge.fury.io/gh/dotmpe%2Fnodejs-express-socketio-seed
     :alt: GIT

Seed project for NodeJS+Express.

Working
  - Basic structure and configuration for extendible Express app.
    No specs are written except the running code w/ comments.

Wanted
  - View-Controller metadata TODO: spec
  - Schema metadata, migration, validation at structure and datatype level.

See below for details, and `Branch docs`_ for work in process.

:XXX: angular client integration either goes or does something together with express-client
:XXX: loose the src/dotmpe too, move stuff to lib/
:XXX: should set-up master again to something without experiments
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

    dotmpe/browser
      - For a really minimal extension module with custom route/page and AMD
        client module.


Branch docs
-----------
master [*]_
  - Initial project structure, documentation.

  f_bootstrap
    - Going to dust off my own Du stylesheets and get bootstrap components and
      layout into the picture.

  f_clientbuild
    - Testing Grunt or Delinting.
    - Found r.js optimizer a bit tempramental. So using require.js
      at client side only.
    - Removed modulr, but may want to do lazy eval later again.
    - Started jade-requirejs-client to experiment with metadata driven pages,
      and to think some about resource representations and navigation.
    - TODO: stylus compiler.

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

