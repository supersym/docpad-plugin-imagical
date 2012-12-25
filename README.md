Introduction
============

This application is a plugin for docpad which mashes up several image and image
asset related loading functions. It is intended to be run at the end of development process and integrate some of the interesting features of several plugins mostly front
the viewpoint of supporting images in the context of stylesheets.

### Pulverizr:

* perform a number of lossless compression routines to squeeze every last bit out of your images;
* transform your inline image url's to base64 encoding, save HTTP Get requests and speed-up your site;
*???? for the rest bundle your assets on several asset hosts to optimize the parallel fetch capabilities of browsers;

### Docpad-plugin-frontend

* get compiled by Grunt.js resources and output links to them with last modified date prefix to effectively reset cache every time resource is re-compiled;
* organize resources into sets that can be selectively redefined in templates and documents meta-data;

### Enhance CSS

* external files stamps to boost chaching (either timestamps or MD5 hashes);
* image embedding to Base64 (to reduce number of requests);
* spawning assets into multiple asset hosts (to paralelize requests);




Prerequisites
-------------

Pulverizr, and the lossless image compression it utilizes comes from a few
independant libraries which need to be on your system. There is no way to overcome
this, unless you want to fully embed these algorithms in node.

Check your package manager or the web to find the correct sources for your system:

+ gifsicle 1.58+
+ libjpeg (or libjpeg-progs if you're using apt)
+ optipng 0.6.3+
+ pngcrush 1.7.0+

