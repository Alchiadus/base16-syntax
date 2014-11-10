path = require 'path'

class Base16

  config:
    scheme:
      type: 'string'
      default: 'Default'
      enum: ["3024", "Ashes", "Atelier Dune", "Atelier Forest", "Atelier Heath", "Atelier Lakeside", "Atelier Seaside", "Bespin", "Brewer", "Chalk", "Codeschool", "Default", "Eighties", "Embers", "Google", "Grayscale", "Greenscreen", "Isotope", "Marrakesh", "Mocha", "Monokai", "Ocean", "Paraiso", "Railscasts", "Shapeshifter", "Solarized", "Tomorrow", "Tube", "Twilight"]
    style:
      type: 'string'
      default: 'Dark'
      enum: ["Dark", "Light"]
    matchUserInterfaceTheme:
      type: 'boolean'
      default: true
      description: "When enabled the style will be matched to the current UI theme by default."

  activate: ->
    ThemeManagerPlus = require './theme-manager-plus'
    @themes = new ThemeManagerPlus
    @packageName = require('../package.json').name
    if /light/.test atom.config.get('core.themes').toString()
      atom.config.setDefaults "#{@packageName}", style: 'Light'
    atom.config.observe "#{@packageName}.scheme", => @enableConfigTheme()
    atom.config.observe "#{@packageName}.style", => @enableConfigTheme()
    atom.workspaceView.command "#{@packageName}:select-theme", @createSelectListView

  enableConfigTheme: ->
    scheme = atom.config.get "#{@packageName}.scheme"
    style = atom.config.get "#{@packageName}.style"
    @enableTheme scheme, style

  enableTheme: (scheme, style) ->
    # No need to enable the theme if it is already active.
    return if @isActiveTheme scheme, style
    # Disable the currently active theme.
    atom.themes.removeStylesheet @getStylePath @activeStyle
    try
      # Try to enable the requested theme.
      @activeTheme?.dispose()
      @activeTheme = @themes.requireLessStylesheet @getStylePath(style), @getSchemeImport(scheme)
      @activeScheme = scheme
      @activeStyle = style
    catch
      # If unsuccessfull enable the default theme.
      @enableDefaultTheme()

  isActiveTheme: (scheme, style) ->
    scheme is @activeScheme and style is @activeStyle

  getStylePath: (style) ->
    path.join __dirname, "..", "themes", "styles", "#{@getNormalizedName style}"

  getSchemeImport: (scheme) ->
    """
    @import "../schemes/#{@getNormalizedName scheme}";
    """

  getNormalizedName: (name) ->
    "#{name}"
      .replace ' ', '-'
      .replace /\b\w/g, (character) -> character.toLowerCase()

  enableDefaultTheme: ->
    scheme = atom.config.getDefault "#{@packageName}.scheme"
    style = atom.config.getDefault "#{@packageName}.style"
    @setThemeConfig scheme, style

  setThemeConfig: (scheme, style) ->
    atom.config.set "#{@packageName}.scheme", scheme
    atom.config.set "#{@packageName}.style", style

  createSelectListView: =>
    Base16SelectListView = require './base16-select-list-view'
    new Base16SelectListView @

  isConfigTheme: (scheme, style) ->
    configScheme = atom.config.get "#{@packageName}.scheme"
    configStyle = atom.config.get "#{@packageName}.style"
    scheme is configScheme and style is configStyle

  destroy: ->
    atom.config.unobserve "#{@packageName}.scheme"
    atom.config.unobserve "#{@packageName}.style"

module.exports = new Base16
