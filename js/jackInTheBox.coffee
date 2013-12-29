#
# Name    : jackInTheBox
# Author  : Matthieu Aussaguel, http://mynameismatthieu.com/, @mattaussaguel
# Version : 0.0.1
# Repo    : https://github.com/matthieua/jackInTheBox
# Website : -
#

jQuery ->
  $.jackInTheBox = ( element, options ) ->
    # current state
    state = ''

    # plugin settings
    @settings = {}

    # jQuery version of DOM element attached to the plugin
    @$element = $ element

    # get particular plugin setting
    @getSetting = ( key ) ->
      @settings[ key ]

    # call one of the plugin setting functions
    @callSettingFunction = ( name, args = [] ) ->
      @settings[name].apply( this, args )

    # Check if box is visible
    @visible = ($box) =>
      viewTop    = @$window.scrollTop()
      viewBottom = viewTop + @$window.height()
      _top       = $box.offset().top
      _bottom    = _top + $box.height()

      _top <= viewBottom and _bottom >= viewTop

    # Show box is visible on scroll
    @show = =>
      @$window.scroll =>
        @$boxes.each (index, box) =>
          $box = $(box)
          if (@visible($box))
            $box.css(visibility: 'visible').addClass @settings.animateClass

    # Set initial settings
    @init = ->
      @settings = $.extend( {}, @defaults, options )

      @$window  = $(window)
      @$boxes   = $(".#{@settings.boxClass}").css(visibility: 'hidden')

      @show() if @$boxes.length

    # initialise the plugin
    @init()

    # make the plugin chainable
    this

  # default plugin settings
  $.jackInTheBox::defaults =
      boxClass:      'box'
      animateClass:  'animated'

  $.fn.jackInTheBox = ( options ) ->
    this.each ->
      if $( this ).data( 'jackInTheBox' ) is undefined
        plugin = new $.jackInTheBox( this, options )
        $( this).data( 'jackInTheBox', plugin )
