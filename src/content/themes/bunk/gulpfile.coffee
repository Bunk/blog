'use strict'

# -- Dependencies --------------------------------------------------------------

gulp        = require 'gulp'
gulpOpts    =
  pattern: ['gulp-*', 'gulp.*', 'main-bower-files']
  replaceString: /\bgulp[\-.]/
plugins     = require('gulp-load-plugins') gulpOpts
_s          = require 'underscore.string'
pkg         = require './package.json'

browserSync = require('browser-sync').create()
reload      = browserSync.reload

delay = (ms, func) -> setTimeout func, ms
delayedReload = -> delay 3000, -> reload()

PORT =
  GHOST: 2368
  BROWSERSYNC: 3000

# -- Files ---------------------------------------------------------------------

dist =
  name       : _s.slugify pkg.name
  css        : 'assets/css'
  js         : 'assets/js'
  prism      : 'assets/prism'

src =
  js         :
    watch    : ['_src/**/*.js']
    prism    : ['bower_components/prism/components/*.js']
    common   : ['bower_components/prism/plugins/autoloader/prism-autoloader.js',
                'bower_components/prism/plugins/command-line/prism-command-line.js',
                '_src/js/**/*.js']

  styles     :
    watch    : ['_src/**/*.scss']
    prism    : ['themes/prism-okaidia.css',
                'plugins/command-line/prism-command-line.css']
    common   : ['_src/styles/*.scss']

  templates  : '**/*.hbs'

banner = [ "/**"
           " * <%= pkg.name %> - <%= pkg.description %>"
           " * @version <%= pkg.version %>"
           " * @link    <%= pkg.homepage %>"
           " * @author  <%= pkg.author.name %> (<%= pkg.author.url %>)"
           " * @license <%= pkg.license %>"
           " */"
           "" ].join("\n")

# -- Tasks ---------------------------------------------------------------------

gulp.task 'prism', ->
  gulp.src src.js.prism
  .pipe gulp.dest dist.prism

gulp.task 'js', ->
  gulp.src plugins.mainBowerFiles().concat src.js.common
  .pipe plugins.filter '**/*.js'
  .pipe plugins.concat dist.name + '.main.js'
  # .pipe plugins.uglify()
  .pipe gulp.dest dist.js

gulp.task 'styles', ->
  gulp.src plugins.mainBowerFiles( overrides: prism: main: src.styles.prism ).concat src.styles.common
  .pipe plugins.filter '**/*.{css,scss}'
  .pipe plugins.order ['normalize.css','*']
  .pipe plugins.sass().on('error', plugins.sass.logError)
  .pipe plugins.concat dist.name + '.main.css'
  # .pipe plugins.cleanCss()
  .pipe gulp.dest dist.css

gulp.task 'server', ->
  browserSync.init
    proxy: "http://localhost:#{PORT.GHOST}"
    port: PORT.BROWSERSYNC
    files: ['assets/**/*.*']
  return

gulp.task 'build', ['styles', 'js', 'prism']

gulp.task 'default', ->
  gulp.start ['build', 'server']
  gulp.watch src.templates, delayedReload
  gulp.watch src.styles.watch, ['styles', reload]
  gulp.watch src.js.watch, ['js', reload]
