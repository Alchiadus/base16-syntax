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
    schemes = atom.config.getSchema('base16-syntax.scheme').enum
    if atom.config.get "#{@base16.packageName}.matchUserInterfaceTheme"
      styles = [atom.config.getDefault "#{@base16.packageName}.style"]
    else
      styles = atom.config.getSchema('base16-syntax.style').enum
    themes = []
    schemes.forEach (scheme) -> styles.forEach (style) ->
      themes.push scheme: scheme, style: style, name: "#{scheme} (#{style})"
    themes

module.exports = Base16SelectListView
