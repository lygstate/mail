#http://source.tigefa.org/tigefa/atom/blob/master/build/Gruntfile.coffee
var process = require('process');
module.exports = function(grunt) {
  grunt.initConfig({
    'build-atom-shell': {
      tag: 'v0.19.5',
      nodeVersion: '0.18.0',
      buildDir: (process.env.TMPDIR || process.env.TEMP || '/tmp') + '/atom-shell',
      projectName: 'mycoolapp',
      productName: 'MyCoolApp'
    }
  });
  grunt.loadNpmTasks('grunt-build-atom-shell');
};

