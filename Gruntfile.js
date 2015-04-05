module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      gruntfile: {
        src: 'Gruntfile.js'
      },
      client: {
        src: [
          'src/dotmpe/**/client/*.js'
        ]
      },
      lib: {
        src: [
          'lib/**/*.js',
          'src/**/*.js'
        ]
      },
      test: {
        src: [ 'test/**/*.js' ]
      },
    },

    coffeelint: {
      options: {
        configFile: '.coffeelint.json'
      },
      client: {
        src: [
          'src/dotmpe/**/client/*.coffee'
        ]
      },
      lib: {
        src: [
          'src/**/*.coffee',
          'lib/**/*.coffee',
          'config/**/*.coffee'
        ]
      }
    },

    yamllint: {
      all: {
        src: [
          'config/*.yaml',
          'src/**/*.meta'
        ]
      }
    },

    nodeunit: {
      files: ['test/**/*_test.js'],
    },

    watch: {
      gruntfile: {
        files: '<%= jshint.gruntfile.src %>',
        tasks: ['jshint:gruntfile']
      },
      client: {
        files: [
            '<%= jshint.lib.client %>',
            '<%= coffeelint.lib.client %>'
        ],
        tasks: [
          'jshint:client',
          'coffeelint:client',
          'build-cients'
        ]
      },
      lib: {
        files: [
            '<%= jshint.lib.src %>',
            '<%= coffeelint.lib.src %>'
        ],
        tasks: ['jshint:lib', 'nodeunit']
      },
      test: {
        files: '<%= jshint.test.src %>',
        tasks: ['jshint:test', 'nodeunit']
      },
    },

/*
TODO: put deps list into require.js app..
*/
    requirejs: {

      client: {
        options: {
          baseUrl: "public",
          paths: {
            app: '../app',
            jquery: 'empty:',
            //cs: "../../../../public/components/require-cs/cs"
          },
          //out: './public/script/client.coffee'
          appDir: 'src/dotmpe/express-client/client',
          modules: [
            //{ name: 'index' }
            //{ name: 'cs!express-client/client/x-frame' }
          ],
          dir: 'public/script/client'
        }
      },

      // XXX: better copy/compile files by hand..
      //'r-app': {
      //  options: {
      //     appDir: "./src/dotmpe/x/backbone/client/",
      //     baseUrl: '.',
      //     dir: './public/script/client/',
      //     paths: {
      //       jquery: "empty:",
      //     },
      //     modules: [
      //       { name: 'dotmpe-x-backbone' }
      //     ],
      //  },
      //},

      project: {
        options: {
          appDir: 'src/dotmpe/project/client',
          baseUrl: '.',// relative to appDir
          paths: {
              app: '../client',
              jquery: 'empty:',
              "coffee-script": "../../../../public/components/coffee-script/extras/coffee-script",
              cs: "../../../../public/components/require-cs/cs"
          },
          modules: [
              { name: 'main',}
          ],
          dir: './public/script/project'
        },
      },

      'x-bookmarks': {
        options: {
          appDir: 'src/dotmpe/x-bookmarks/client',
          baseUrl: '.',// relative to appDir
          paths: { },
          modules: [ ],
          dir: './public/script/x-bookmarks',
        }
      }

    },

  });

  // auto load grunt contrib tasks from package.json
  require('load-grunt-tasks')(grunt);

  grunt.registerTask('lint', [
    'coffeelint', 'jshint', 'yamllint'
  ]);
  grunt.registerTask('test', [
    'nodeunit' 
  ]);
  grunt.registerTask('build-client', [
    'requirejs:client'
  ]);
  grunt.registerTask('client', [
    'jshint:client',
    'coffeelint:client',
    'build-client'
  ]);

  // Default task.
  grunt.registerTask('default', [
    'lint', 'test' 
  ]);

};
