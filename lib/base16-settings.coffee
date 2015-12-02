settings =
  config:
    scheme:
      type: 'string'
      default: 'Default'
      enum: [
        "3024"
        "Apathy"
        "Ashes"
        "Atelier Dune"
        "Atelier Forest"
        "Atelier Heath"
        "Atelier Lakeside"
        "Atelier Seaside"
        "Bespin"
        "Brewer"
        "Bright"
        "Chalk"
        "Codeschool"
        "Colors"
        "Default"
        "Eighties"
        "Embers"
        "Flat"
        "Google"
        "Grayscale"
        "Greenscreen"
        "Harmonic"
        "Hopscotch"
        "Isotope"
        "Marrakesh"
        "Mocha"
        "Monokai"
        "Ocean"
        "Paraiso"
        "Pop"
        "Railscasts"
        "Shapeshifter"
        "Solarized"
        "Summerfruit"
        "Tomorrow"
        "Tube"
        "Twilight"
      ]
    style:
      type: 'string'
      default: 'Dark'
      enum: ["Dark", "Light"]
    matchUserInterfaceTheme:
      type: 'boolean'
      default: true
      description: "When enabled the style will be matched to the current UI theme by default."

module.exports = settings
