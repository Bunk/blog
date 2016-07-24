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

PORT =
  GHOST: 2387
  BROWSERSYNC: 3000

# -- Files ---------------------------------------------------------------------

dist =
  name       : _s.slugify pkg.name
  css        : 'assets/css'
  js         : 'assets/js'

src =
  js         :
    common   : ['_src/js/**/*.js']

  styles     :
    common   : ['_src/{css,scss}/*.{css,scss}']

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

# gulp.task 'js-common', ->
#   gulp.src src.js.common.main
#   .pipe changed dist.js
#   .pipe coffee().on 'error', gutil.log
#   .pipe addsrc src.js.common.vendor
#   .pipe concat dist.name + '.common.js'
#   .pipe uglify()
#   .pipe header banner, pkg: pkg
#   .pipe gulp.dest dist.js
#   return

# gulp.task 'js-post', ->
#   gulp.src src.js.post
#   .pipe changed dist.js
#   .pipe concat dist.name + '.post.js'
#   .pipe uglify()
#   .pipe header banner, pkg: pkg
#   .pipe gulp.dest dist.js
#   return

# gulp.task 'styles', ->
#   gulp.src src.css.vendor
#   .pipe changed dist.css
#   .pipe addsrc src.sass.main
#   .pipe sass().on 'error', gutil.log
#   .pipe concat '' + dist.name + '.css'
#   .pipe prefix()
#   .pipe strip
#     all: true
#   .pipe shorthand()
#   .pipe cssmin()
#   .pipe header banner, pkg: pkg
#   .pipe gulp.dest dist.css
#   return

gulp.task 'js', ->
  gulp.src plugins.mainBowerFiles().concat src.js.common
  .pipe plugins.filter '**/*.js'
  .pipe plugins.concat dist.name + '.main.js'
  .pipe plugins.uglify()
  .pipe gulp.dest dist.js

gulp.task 'styles', ->
  gulp.src plugins.mainBowerFiles().concat src.styles.common
  .pipe plugins.filter '**/*.{css,scss}'
  .pipe plugins.concat dist.name + '.main.css'
  .pipe plugins.cleanCss()
  .pipe gulp.dest dist.css

gulp.task 'server', ->
  browserSync.init
    proxy: "http://localhost:#{PORT.GHOST}"
    port: PORT.BROWSERSYNC
    files: ['assets/**/*.*']
  return

# gulp.task 'js', ['js-common']
# gulp.task 'styles', ['css-vendor']
gulp.task 'build', ['styles', 'js']

gulp.task 'default', ->
  gulp.start ['build', 'server']
  gulp.watch( src.templates ).on("change", reload)
  gulp.watch src.styles.common, ['styles', reload]
  gulp.watch src.js.common, ['js', reload]
  # gulp.watch src.js.post, ['js-post', reload]
