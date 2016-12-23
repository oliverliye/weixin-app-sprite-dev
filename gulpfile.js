var gulp = require('gulp');
var coffee = require('gulp-coffee');
var coffeeReactTransform = require('gulp-coffee-react-transform');
var babel = require('gulp-babel');

coffeeConfig = {
	bare: true
}

babelConfig = {
	presets: ['es2015']
}

var paths = {
	cli: {
		src: 'weixin-app-sprite-cli/**/*.*',
		code: 'weixin-app-sprite-cli/**/*.coffee',
	},
	rnweui: {
		src: 'rnweui/**/*.*',
		code: 'rnweui/**/*.coffee',
	},
	sprite: {
		src: 'weixin-app-sprite/**/*.*',
		code: 'weixin-app-sprite/**/*.coffee',
	},
	wxssrn: {
		src: 'wxssrn/**/*.*',
		code: 'wxssrn/**/*.coffee',
	},
	wxdbrn: {
		src: 'wxdatabindrn/**/*.*',
		code: 'wxdatabindrn/**/*.coffee',
	}
};


// weixin-app-sprite-cli

gulp.task('cli', function() {
	return gulp.src(paths.cli.code)
		.pipe(coffee(coffeeConfig))
		.pipe(gulp.dest("./cli"));
});

gulp.task('cli-release', function() {
	return gulp.src(paths.cli.code)
		.pipe(coffee(coffeeConfig))
		.pipe(babel(babelConfig))
		.pipe(gulp.dest("../weixin-app-sprite-cli"));
});

gulp.task('cli-src', function() {
	return gulp.src(paths.cli.src)
		.pipe(gulp.dest("../weixin-app-sprite-cli/src"));
});

gulp.task('npm-cli', ['cli-src', 'cli-release']);

// rnweui

gulp.task('rnweui', function() {
	var coffeelint = require('gulp-coffeelint');

	return gulp.src(paths.rnweui.code)

		.pipe(coffeeReactTransform())
		.pipe(coffeelint())
    	.pipe(coffeelint.reporter())
		.pipe(coffee(coffeeConfig))
		//.pipe(babel(babelConfig))
		.pipe(gulp.dest("./test/node_modules/rnweui"));
});

gulp.task('rnweui-release', function() {
	return gulp.src(paths.rnweui.code)
		.pipe(coffeeReactTransform())
		.pipe(coffee(coffeeConfig))
		//.pipe(babel(babelConfig))
		.pipe(gulp.dest("../rnweui"));
});

gulp.task('rnweui-src', function() {
	return gulp.src(paths.rnweui.src)
		.pipe(gulp.dest("../rnweui/src"));
});

gulp.task('npm-rnweui', ['rnweui-src', 'rnweui-release']);

// weixin-app-sprite

gulp.task('sprite', function() {
	return gulp.src(paths.sprite.code)
		.pipe(coffee(coffeeConfig))
		.pipe(gulp.dest("./test/node_modules/weixin-app-sprite"));
});

gulp.task('sprite-release', function() {
	return gulp.src(paths.sprite.code)
		.pipe(coffee(coffeeConfig))
		.pipe(babel(babelConfig))
		.pipe(gulp.dest("../weixin-app-sprite"));
});

gulp.task('sprite-src', function() {
	return gulp.src(paths.sprite.src)
		.pipe(gulp.dest("../weixin-app-sprite/src"));
});

gulp.task('npm-sprite', ['sprite-src', 'sprite-release']);

// wxssrn

gulp.task('wxssrn', function() {
	return gulp.src(paths.wxssrn.code)
		.pipe(coffee(coffeeConfig))
		.pipe(babel(babelConfig))
		.pipe(gulp.dest("./node_modules/wxssrn"));
});

gulp.task('wxssrn-release', function() {
	return gulp.src(paths.wxssrn.code)
		.pipe(coffee(coffeeConfig))
		.pipe(babel(babelConfig))
		.pipe(gulp.dest("../wxssrn"));
});

gulp.task('wxssrn-src', function() {
	return gulp.src(paths.wxssrn.src)
		.pipe(gulp.dest("../wxssrn/src"));
});

gulp.task('npm-wxssrn', ['wxssrn-src', 'wxssrn-release']);


// wxdatabindrn

gulp.task('wxdbrn', function() {
	return gulp.src(paths.wxdbrn.code)
		.pipe(coffee(coffeeConfig))
		.pipe(babel(babelConfig))
		.pipe(gulp.dest("./node_modules/wxdatabindrn"));
});

gulp.task('wxdbrn-release', function() {
	return gulp.src(paths.wxdbrn.code)
		.pipe(coffee(coffeeConfig))
		.pipe(babel(babelConfig))
		.pipe(gulp.dest("../wxdatabindrn"));
});

gulp.task('wxdbrn-src', function() {
	return gulp.src(paths.wxdbrn.src)
		.pipe(gulp.dest("../wxdatabindrn/src"));
});

gulp.task('npm-wxdbrn', ['wxdbrn-src', 'wxdbrn-release']);


gulp.task('all', ['cli', 'rnweui', 'sprite', 'wxssrn', 'wxdbrn']);
gulp.task('npm-all', ['npm-cli', 'npm-rnweui', 'npm-sprite', 'npm-wxssrn', 'npm-wxdbrn']);




gulp.task('watch', ['cli', 'sprite', 'wxssrn', 'wxdbrn'], function() {
	gulp.watch(paths.cli.code, ['cli']);
	gulp.watch(paths.rnweui.code, ['rnweui']);
	gulp.watch(paths.sprite.code, ['sprite']);
	gulp.watch(paths.wxssrn.code, ['wxssrn']);
	gulp.watch(paths.wxdbrn.code, ['wxdbrn']);
});

