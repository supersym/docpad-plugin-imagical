#!/usr/bin/env coffee

# First we'll have to see what images stylesheets have and need to become base64
# Note: increases some, about 30% extra space is taken up
fs = require("fs")
path = require("path")
util = require("util")
EnhanceCSS = require("enhance-css")

# Next for the other assets, if we can, compress them with better algorithms
Pulverizr = require("pulverizr")

# Finally, we look at ..?
Frontend = require("docpad-plugin-frontend")

log = (msg,args...) ->
  console.log msg,args

enhance = (source, callback) ->
  new EnhanceCSS(
    rootPath:       config.rootPath
    assetHosts:     config.assetHosts
    noEmbedVersion: config.noEmbed
    cryptedStamp:   config.cryptedStamp
    pregzip:        config.pregzip
    stamp:          config.stamp
  ).process source, (error, data) ->
    throw error  if error
    callback data

write = (target, content) ->
  if typeof target is "string"
    fs.writeFileSync target, content.plain
    fs.writeFileSync target + ".gz", content.compressed  if config.pregzip
  else
    target.write content

output = (enhanced) ->
  if config.target
    write config.target, enhanced.embedded
    write config.target.replace(/\.(\w+)$/, "-noembed.$1"), enhanced.notEmbedded  if config.noEmbed
  else
    write process.stdout, enhanced.embedded



if config.source
  fs.readFile config.source, "utf8", (error, text) ->
    throw error  if error
    enhance text, output

else

  # TODO: Docpad graceful pass, don't get from stdin

  stdin = process.openStdin()
  stdin.setEncoding "utf-8"
  text = ""
  stdin.on "data", (chunk) ->
    text += chunk

  stdin.on "end", ->
    enhance text, output

# Export Plugin
module.exports = (BasePlugin) ->

    # Define Plugin
    class Imagical extends BasePlugin

        # Plugin name
        name: 'docpad-plugin-imagical'

        # Configuration
        config:
           source: null
            target: null
            rootPath: null
            assetHosts: null
            pregzip: false
            noEmbed: false
            cryptedStamp: false
            stamp: true

