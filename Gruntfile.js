#http://source.tigefa.org/tigefa/atom/blob/master/build/Gruntfile.coffee
var os = require('os');
var path = require('path');
module.exports = function(grunt) {
  grunt.initConfig({
    'build-atom-shell': {
      tag: 'v0.19.5',
      nodeVersion: '0.18.0',
      buildDir: path.join(os.tmpdir(), 'atom-shell')
      projectName: 'mycoolapp',
      productName: 'MyCoolApp'
    },
    'download-atom-shell': {
      version: packageJson.atomShellVersion
      outputDir: 'atom-shell'
      downloadDir: atomShellDownloadDir
      rebuild: true  # rebuild native modules after atom-shell is updated
    }
  });
  grunt.loadNpmTasks('grunt-build-atom-shell');
  grunt.loadNpmTasks('grunt-download-atom-shell')
};

