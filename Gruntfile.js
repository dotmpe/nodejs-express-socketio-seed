'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      gruntfile: {
        src: 'Gruntfile.js'
      },
      lib: {
        src: ['lib/**/*.js', 'test/**/*.js', 'src/**/*.js' ]
      },
      test: {
        src: ['test/**/*.js']
      },
    },
    coffeelint: {
      options: {
        configFile: '.coffeelint.json'
      },
      src: [
        'bin/*.coffee',
        'src/**/*.coffee',
        'lib/**/*.coffee',
        'config/**/*.coffee'
      ]
    },
    nodeunit: {
      files: ['test/**/*_test.js'],
    },
    watch: {
      gruntfile: {
        files: '<%= jshint.gruntfile.src %>',
        tasks: ['jshint:gruntfile']
      },
      lib: {
        files: '<%= jshint.lib.src %>',
        tasks: ['jshint:lib', 'nodeunit']
      },
      test: {
        files: '<%= jshint.test.src %>',
        tasks: ['jshint:test', 'nodeunit']
      },
    },
  });

  // auto load grunt contrib tasks from package.json
  require('load-grunt-tasks')(grunt);

  // auto load parts from grunt/
  //require('load-grunt-config')(grunt);

  // Default task.
  grunt.registerTask('lint', [ 'coffeelint', 'jshint' ]);
  grunt.registerTask('test', [ 'nodeunit' ]);
  grunt.registerTask('default', [ 'lint', 'test' ]);
};
