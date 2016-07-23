var path        = require('path'),
    gulp        = require('gulp'),
    concat      = require('gulp-concat'),
    plumber     = require('gulp-plumber'),
    server      = require('tiny-lr')(),
    refresh     = require('gulp-livereload'),
    // mocha       = require('gulp-mocha'),
    // stylus      = require('gulp-stylus'),
    // sass        = require('gulp-sass'),
    notify      = require('gulp-notify'),
    nodemon     = require('gulp-nodemon'),
    // jshint      = require('gulp-jshint'),
    lrPort      = 35729;

function getPath( directory ) {
  var rootPath = process.env.GHOST_CONTENT || __dirname;
  return path.join(rootPath, directory);
}

var paths = {
  styles: [
    getPath( '/**/*.{css,scss}' )
  ],

  // assets: ['./client/assets/'],

  scripts: [
    getPath( '/**/*.js' )
  ],

  html: [
    getPath( './**/*.{html,' )
  ],

  // server: {
  //   js: ['./server/**/*.js'],
  //   specs: ['./server/cards/specs/*.js']
  // }
};


gulp.task('serve', function(){
  nodemon({'script': 'index.js'});
});

// gulp.task('lint', function(){
//   return gulp.src(paths.scripts)
//     .pipe(plumber())
//     .pipe(jshint())
//     .pipe(jshint.reporter('default'))
//     .pipe(notify({message: 'jshint done'}));
// });

gulp.task('scripts', function(){
  return gulp.src(paths.scripts)
    .pipe(plumber())
    // .pipe(concat('main.js'))
    // .pipe(gulp.dest('./client/'))
    .pipe(refresh(server))
    .pipe(notify({message: 'JS concated'}));
});

// gulp.task('test', function(){
//   return gulp.src(paths.server.specs)
//     .pipe(mocha({reporter: 'spec'}))
//     .pipe(notify({message: "Specs ran"}));
// });

gulp.task('styles', function(){
  return gulp.src(paths.styles)
    .pipe(plumber())
    // .pipe(stylus())
    // .pipe(gulp.dest('/client/styles/css'))
    .pipe(refresh(server))
    .pipe(notify({message: 'stylus done'}));
});

gulp.task('html', function(){
  return gulp.task('html', function(){
    gulp.src(paths.html)
      .pipe(refresh(server))
      .pipe(notify({message: 'Views refreshed'}));
  });
});

gulp.task('build', ['html', 'styles', 'scripts']);

gulp.task('lr', function(){
  server.listen(lrPort, function(err){
    if(err) {return console.error(err);}
  });
});

gulp.task('watch', function(){
  gulp.watch(paths.html, ['html']);
  gulp.watch(paths.scripts, ['scripts']);
  gulp.watch(paths.styles, ['styles']);
});

gulp.task('default', ['build', 'lr', 'serve', 'watch']);
