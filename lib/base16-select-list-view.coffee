fs = require 'fs'
path = require 'path'

{SelectListView} = require 'atom'

class Base16SelectListView extends SelectListView

  initialize: (@base16) ->
    super
    @addClass 'overlay from-top'
    @list.addClass 'mark-active'
    @setItems @getThemes()
    atom.workspaceView.append @
    @focusFilterEditor()
    @selectItemView @list.find 'li:last'
    @selectItemView @list.find '.active'
    @initialized = true

  viewForItem: (theme) ->
    element = document.createElement 'li'
    if @base16.isConfigTheme theme.scheme, theme.style
      element.classList.add 'active'
    element.textContent = theme.name
    element

  getFilterKey: ->
    'name'

  selectItemView: (view) ->
    super
    theme = @getSelectedItem()
    # Only preview the selected theme if the list is initialized.
    @base16.enableTheme theme.scheme, theme.style if @initialized

  confirmed: (theme) ->
    @confirming = true
    @base16.setThemeConfig theme.scheme, theme.style
    @cancel()
    @confirming = false

  cancel: ->
    super
    @base16.enableConfigTheme() unless @confirming

  getThemes: ->
    schemes = fs.readdirSync @base16.getSchemesDir()
      .map (scheme) -> scheme.replace /.less/, ''
    if atom.config.get "#{@base16.packageName}.matchUserInterfaceTheme"
      styles = [atom.config.getDefault "#{@base16.packageName}.style"]
    else
      styles = fs.readdirSync @base16.getStylesDir()
        .map (style) -> style.replace /.less/, ''
    themes = []
    schemes.forEach (scheme) -> styles.forEach (style) ->
      name = "#{scheme} (#{style})"
        .replace /-/, ' '
        .replace /\b\w/g, (character) -> character.toUpperCase()
      themes.push scheme: scheme, style: style, name: name
    themes

module.exports = Base16SelectListView
