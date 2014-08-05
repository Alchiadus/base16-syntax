path = require 'path'

class Base16

  activate: ->
    ThemeManagerPlus = require './theme-manager-plus'
    @themes = new ThemeManagerPlus
    @packageName = require('../package.json').name
    atom.config.setDefaults "#{@packageName}", scheme: 'default'
    atom.config.setDefaults "#{@packageName}", style: 'dark'
    enabledThemes = atom.config.get('core.themes').toString()
    if /dark/.test enabledThemes
      atom.config.setDefaults "#{@packageName}", matchUserInterfaceTheme: true
    else if /light/.test enabledThemes
      atom.config.setDefaults "#{@packageName}", style: 'light'
      atom.config.setDefaults "#{@packageName}", matchUserInterfaceTheme: true
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
      @themes.requireLessStylesheet @getStylePath(style), @getSchemeImport(scheme)
      @activeScheme = scheme
      @activeStyle = style
    catch
      # If unsuccessfull enable the default theme.
      @enableDefaultTheme()

  isActiveTheme: (scheme, style) ->
    scheme is @activeScheme and style is @activeStyle

  getStylePath: (style) ->
    path.join __dirname, "..", "themes", "styles", "#{style}"

  getSchemeImport: (scheme) ->
    """
    @import "#{@getSchemesDir()}/#{scheme}";
    """

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

  getSchemesDir: ->
    path.join __dirname, "..", "themes", "schemes"

  getStylesDir: ->
    path.join __dirname, "..", "themes", "styles"

  isConfigTheme: (scheme, style) ->
    configScheme = atom.config.get "#{@packageName}.scheme"
    configStyle = atom.config.get "#{@packageName}.style"
    scheme is configScheme and style is configStyle

  destroy: ->
    atom.config.unobserve "#{@packageName}.scheme"
    atom.config.unobserve "#{@packageName}.style"

module.exports = new Base16
