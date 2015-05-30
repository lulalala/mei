# Image upload control

class @ImageUpload
  uploadMethod: null

  constructor: (@container)->
    @setupNestedAttributes()
    @setupSwtiching()

  setupNestedAttributes: ->
    @container.nestedAttributes
      bindAddTo: $(".actions .add")
      collectionName: 'images'
      collectIdAttributes: false
      $clone: @container.children('.field')

    @container.find('input').focus (e)=>
      inputs = @container.find("input:enabled.upload[type=#{@uploadMethod}]").not(e.target).filter (index)->
        @value.length == 0

      if inputs.length == 0
        @container.nestedAttributes("add")

  setupSwtiching: ->
    @updateView()
    @setCurrentUploadMethod()

    @container.find('.actions a.switch').click (e)=>
      e.preventDefault()

      # toggle disable
      @container.find('.field input.upload').prop 'disabled', (i,v)=>
        !v

      @updateView()
      @setCurrentUploadMethod()

  setCurrentUploadMethod: ->
    if @container.find("input:enabled.upload[type=file]").length
      @uploadMethod = 'file'
    else
      @uploadMethod = 'url'


  updateView: ->
    # visibility
    @container.find('.field input').each (index, input)=>
      input = $(input)
      if input.prop('disabled')
        input.addClass('hide')
      else
        input.removeClass('hide')

$ ->
  new ImageUpload($('.file-section'))
