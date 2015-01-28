module.exports = function(grunt) {

// This is the configuration.
grunt.initConfig({
  concat: {
    options: {
      separator: ';',
    },
    jsFiles: {
      src: ['src/query-string.js', 'src/full-bleed-bookmarklet-v2.js'],
      dest: 'src/full-bleed.js',
    },
    post: {
      options: {
        banner: "javascript:"
      },
      src: ['dist/full-bleed.js'],
      dest: 'dist/full-bleed.js',
    },
  },
  uglify: {
    options: {
      mangle: false
    },
    my_target: {
      files: {
        'dist/full-bleed.js': ['src/full-bleed.js']
      }
    }
  }
});

  // Load the plugin that provides the "concat" task.
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  // Default task(s).
  grunt.registerTask('default', ['concat:jsFiles','uglify','concat:post']);
};