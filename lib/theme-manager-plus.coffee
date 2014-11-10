fs = require 'fs'
path = require 'path'

# Helper class to load less stylesheets with dynamic imports and/or variables.
class ThemeManagerPlus

  # Public: Resolve and apply the less stylesheet specified by the path.
  #
  # lessStylesheetPath - A {String} path to the stylesheet that can be an
  #                      absolute path or a relative path that will be resolved
  #                      against the load path.
  #
  # preliminaryContent - Optional (String) preliminary content that will be
  #                      prepended to the content of the stylesheet.
  #
  # Returns the absolute path to the required stylesheet.
  requireLessStylesheet: (lessStylesheetPath, preliminaryContent = '') ->
    if fullPath = atom.themes.resolveStylesheet lessStylesheetPath
      content = @loadLessStylesheet fullPath, preliminaryContent
      atom.themes.applyStylesheet fullPath, content
    else
      throw new Error "Could not find a file at path '#{lessStylesheetPath}'"

  loadLessStylesheet: (lessStylesheetPath, preliminaryContent = '') ->
    try
      if preliminaryContent isnt ''
        lessContent = fs.readFileSync lessStylesheetPath, 'utf8'
        atom.themes.lessCache.cssForFile lessStylesheetPath,
          [preliminaryContent, lessContent].join '\n'
      else
        atom.themes.lessCache.read lessStylesheetPath
    catch e
      console.error """
        Error compiling less stylesheet: #{lessStylesheetPath}
        Line number: #{e.line}
        #{e.message}
      """

module.exports = ThemeManagerPlus
