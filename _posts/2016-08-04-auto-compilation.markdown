---
layout: post
title:  "Auto-Compilation"
date:   2016-08-04 12:00:00 -0500
categories:
label: ep-009
tiny_description: Use Grunt to automatically compile your Elm project when a file is saved.
---

Instead of manually running `elm-make` yourself, use Grunt to automatically compile your Elm files anytime you save a change. Your Gruntfile (`gruntfile.js`) provides configuration to the `grunt-elm` plugin, which knows how to compile Elm, and the `grunt-contrib-watch` plugin, which watches for filesystem changes to the specified files.

### Examples

##### Install
```bash
$ npm install grunt --save-dev
$ npm install grunt-elm --save-dev
$ npm install grunt-contrib-watch --save-dev
```

##### Gruntfile.js
```js
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
```


### Links

* [Grunt](http://gruntjs.com)
* [grunt-elm plugin](https://github.com/rtfeldman/grunt-elm)
