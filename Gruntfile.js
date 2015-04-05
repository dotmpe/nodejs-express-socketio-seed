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
          'bin/*.coffee',
          'src/**/*.coffee',
          'lib/**/*.coffee',
          'config/**/*.coffee'
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

    requirejs: {

      browser: {
        options: {
          appDir: 'src/dotmpe/browser/client',
          baseUrl: ".",
          paths: {
            app: '../app',
            jquery: 'empty:'
          },
          dir: './public/script/browser'
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
    'coffeelint', 'jshint' 
  ]);
  grunt.registerTask('test', [
    'nodeunit' 
  ]);
  grunt.registerTask('build-client', [
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
