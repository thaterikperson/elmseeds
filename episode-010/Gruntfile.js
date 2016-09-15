module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    watch: {
      gruntfile: {
        files: ['*.elm'],
        tasks: ['elm']
      }
    },
    elm: {
      compile: {
        files: {
          'output.js': 'Main.elm'
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-elm');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('default', ['elm']);

};
