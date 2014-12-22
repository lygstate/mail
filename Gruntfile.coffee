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
    uglify:
      main:
        options:
          banner: "/*! <%= pkg.name %> <%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"
        dist:
          files:
            "public/<%= pkg.name %>.min.js": ["public/main.js"]


    replace:
      standalone:
        src: ["build/<%= currentBuild %>/platform.js"]
        dest: "build/<%= currentBuild %>/platform.js"
        replacements: [
          from: "global" # string replacement
          to: "fakeGlobal"
        ]
    copy:
      integration:
        files: [
        ]
      standalone:
        files: [
          {src: "package.json",
          dest: "build/<%= currentBuild %>/package.json"}
          {expand: true, src: ['src/**'], dest: 'build/<%= currentBuild %>'}
        ]
      desktop:
        files: [
          {src: "package.json",
          dest: "build/<%= currentBuild %>/package.json"}
          {expand: true, src: ['src/**'], dest: 'build/<%= currentBuild %>'}
        ]

    rename:
      desktopFinal:
        src: 'build/<%= currentBuild %>' 

      
      desktopFinalTOO:
        dest: 'build/<%= currentBuild %>/resources/app' 
        src: '_tmp/app'
      
      appname:
        src: 'build/<%= currentBuild %>/atom'
        dest: 'build/<%= currentBuild %>/<%= appname %>'  
      

    clean:
      integration: ["build/<%= currentBuild %>"]
      postIntegration: ["build/<%= currentBuild %>/platform.js", "build/<%= currentBuild %>/polymer-nw-example.js"]
      standalone: ["build/<%= currentBuild %>"]
      postStandalone: ["build/<%= currentBuild %>/platform.js", "build/<%= currentBuild %>/index.js"]

      desktop:["build/<%= currentBuild %>"]
      postDesktop:["build/<%= currentBuild %>/resources/default_app/"]
    
    "build-atom-shell-app":
      options:
        app_dir: 'src/'
        platforms: [
          "darwin"
          "win32"
        ]
      
    compress:
      desktop:
        options: 
          archive: "build/<%= currentBuild %>/<%= appname %>.zip"
        expand: true
        cwd: 'build/<%= currentBuild %>/'
        src: ['**']
        dest: ''
          
  
  #generic
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-rename"
  grunt.loadNpmTasks "grunt-exec"
  grunt.loadNpmTasks "grunt-text-replace"
  grunt.loadNpmTasks "grunt-contrib-clean"
  
  #builds generation
  grunt.loadNpmTasks "grunt-browserify"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-htmlmin"
  grunt.loadNpmTasks "grunt-atom-shell-app-builder"
  grunt.loadNpmTasks "grunt-contrib-compress"
  
  #release cycle

  # Task(s).
  grunt.registerTask "core", ["browserify", "uglify:main"]
  
  #Builds
  @registerTask 'build', 'Build polymer-nw-example for the chosen target/platform etc', (target = 'browser', subTarget='standalone') =>
    minify = grunt.option('minify');
    platform = grunt.option('platform');
    appname = grunt.option('appname');
    compress = grunt.option('compress');
    console.log("target", target, "sub", subTarget,"minify",minify,"platform",platform,"appname", appname)
    
    grunt.config.set("currentBuild", "#{target}-#{subTarget}")
    grunt.config.set("appname", appname);
    
    @task.run "clean:#{subTarget}"
    @task.run "copy:#{subTarget}"
    @task.run "replace:#{subTarget}"

    if appname
      @task.run "rename:appname"
    @task.run "build-atom-shell-app"
    if compress
      @task.run "compress:desktop"#currently losing correct flags for executables, see https://github.com/gruntjs/grunt-contrib-compress/pull/110

