path = require('path')
rootPath = path.normalize(__dirname + '/..')
templatePath = path.normalize(__dirname + '/../app/mailer/templates')
notifier =
  service: 'postmark',
  APN: false,
  email: false,
  actions: ['comment'],
  tplPath: templatePath,
  key: 'POSTMARK_KEY',
  parseAppId: 'PARSE_APP_ID',
  parseApiKey: 'PARSE_MASTER_KEY'

module.exports =

  production:
    #root: rootPath
    root: __dirname
    modules: [
      'dotmpe/x-bookmarks'
    ]
    lib:
      js:
        requirejs: '/components/requirejs/require.js'
        require_main: []
      include_js: []

  test:
    root: __dirname
    app: name: 'Nodejs Express Socket IO Demo (test)'
    modules: []
    lib:
      js:
        requirejs: '/components/requirejs/require.js'
        require_main: []
      include_js: []
    # old
    db: 'mongodb://localhost/noobjs_test'
    notifier: notifier
    facebook: null
    ###
      clientID: 'APP_ID'
      clientSecret: 'APP_SECRET'
      callbackURL: 'http://localhost:3000/auth/facebook/callback'
    ###
    twitter: null
    ###
      clientID: 'CONSUMER_KEY'
      clientSecret: 'CONSUMER_SECRET'
      callbackURL: 'http://localhost:3000/auth/twitter/callback'
    ###
    github: null
    ###
      clientID: 'APP_ID'
      clientSecret: 'APP_SECRET'
      callbackURL: 'http://localhost:3000/auth/github/callback'
    ###
    google: null
    ###
      clientID: 'APP_ID'
      clientSecret: 'APP_SECRET'
      callbackURL: 'http://localhost:3000/auth/google/callback'
    ###
    linkedin: null
    ###
      clientID: 'CONSUMER_KEY'
      clientSecret: 'CONSUMER_SECRET'
      callbackURL: 'http://localhost:3000/auth/linkedin/callback'
    ###

  development:
    root: __dirname
    app: name: 'Nodejs Express Socket IO Demo (dev)'
    urls:
      login: '/login'
      base: 'http://localhost:3000'
    lib:
      js:
        socket_io: '/socket.io/socket.io.js'
        jquery: '/components/jquery/dist/jquery.js'
        bootstrap: '/components/bootstrap/dist/js/bootstrap.js'
        coffeescript: '/components/coffee-script/extras/coffee-script.js'
        angular: '/components/angular/angular.min.js'
        requirejs: '/components/requirejs/require.js'
        require_main: []
      # booststrap here without requirejs:
      include_js: [
        'socket_io'
        'jquery'
        'coffeescript'
        'bootstrap'
      ]
      coffeescript:
        app: '/script/app.coffee'
      css: [
        '/components/bootstrap/dist/css/bootstrap.css'
        '/components/bootstrap/dist/css/bootstrap-theme.css'
        #/style/bootstrap-responsive.min.css'
        '/style/app.css'
      ]
    # extension modules to load:
    modules: [
      'dotmpe/project'
      'dotmpe/browser'
      'dotmpe/x-bookmarks'
      'dotmpe/x/backbone'
      #'dotmpe/x/backbone/backend',
      #'dotmpe/x/backbone/frontend'
    ]
    database:
      main:
        # knex 0.6.20 config
        client: 'sqlite3'
        connection:
          filename: __noderoot + '/main.sqlite3.db'
          #filename: '/Users/berend/htdocs/.cllct/bms.sqlite'
        migrations:
          tableName: 'knex_migrations'
          directory: __noderoot + '/migrations/main'

    notifier: notifier
    facebook: {}
    twitter: {}
    github: {}
    google: {}
    linkedin: {}

    # XXX old
    db: 'mongodb://localhost/noobjs_dev'

