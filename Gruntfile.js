module.exports = function(grunt) {

// This is the configuration.
grunt.initConfig({
  concat: {
    options: {
      separator: ';',
    },
    dist: {
      src: ['src/jquery-2.1.3.min.js', 'src/query-string.js', 'src/full-bleed-bookmarklet-v2.js'],
      dest: 'dist/full-bleed.js',
    },
  },
});

  // Load the plugin that provides the "concat" task.
  grunt.loadNpmTasks('grunt-contrib-concat');

  // Default task(s).
  grunt.registerTask('default', ['concat']);
};