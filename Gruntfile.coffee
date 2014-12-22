module.exports = (grunt) ->
  
  #different builds:
  # browser
  # -->standalone (index.html)
  # -->integration (custom element + deps only)
  # desktop
  # -->linux
  # -->win
  # -->mac

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    currentBuild: null
    appname:null

    "build-atom-shell-app":
      options:
        app_dir: 'src/'
        platforms: [
          "win32"
        ]

  #generic
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-rename"
  grunt.loadNpmTasks "grunt-exec"
  grunt.loadNpmTasks "grunt-text-replace"
  grunt.loadNpmTasks "grunt-contrib-clean"
  
  #builds generation
  grunt.loadNpmTasks "grunt-browserify"
  grunt.loadNpmTasks "grunt-contrib-htmlmin"
  grunt.loadNpmTasks "grunt-atom-shell-app-builder"
  grunt.loadNpmTasks "grunt-contrib-compress"
  
  #release cycle

  #Builds
  @registerTask 'build', 'Build polymer-nw-example for the chosen target/platform etc', (target = 'browser', subTarget='standalone') =>
    minify = grunt.option('minify');
    platform = grunt.option('platform');
    appname = grunt.option('appname');
    compress = grunt.option('compress');
    console.log("target", target, "sub", subTarget,"minify",minify,"platform",platform,"appname", appname)
    
    grunt.config.set("currentBuild", "#{target}-#{subTarget}")
    grunt.config.set("appname", appname);

    @task.run "build-atom-shell-app"
