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
      test: {
        src: [
          'test/**/*.coffee'
        ]
      },
      lib: {
        src: [
          '*.coffee',
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

    stylus: {
      compile: {
        files: {
          'public/style/pkg-lib.css': [ 'lib/**/*.styl' ]
        }
      }
    },

    clean: {
      build: {
        src: [
          'public/style/pkg-*.css',
          'public/script/pkg-*.js',
          'public/script/dotmpe/'
        ]
      }
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
        tasks: [
          'jshint:lib',
          'nodeunit'
        ]
      },
      test: {
        files: '<%= jshint.test.src %>',
        tasks: [
          'jshint:test',
          'nodeunit'
        ]
      },
    },

  });

  // auto load grunt contrib tasks from package.json
  require('load-grunt-tasks')(grunt);

  grunt.registerTask('init', [
    'make:init-config'
  ]);
  grunt.registerTask('lint', [
    'coffeelint',
    'jshint',
    'yamllint'
  ]);
  grunt.registerTask('test', [
    'nodeunit'
  ]);
  grunt.registerTask('build-client', [
    'make:build-client',
  ]);
  grunt.registerTask('client', [
    'jshint:client',
    'coffeelint:client',
    'build-client'
  ]);
  grunt.registerTask('build', [
    'client', 'stylus'
  ]);

  // Default task.
  grunt.registerTask('default', [
    'lint',
    'test'
  ]);

};
