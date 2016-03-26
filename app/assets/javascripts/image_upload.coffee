# Image upload control

class @ImageUpload
  uploaded: 0
  failed: 0
  waitingForUpload: false
  # jQuery Object
  statusLabel: null

  # @form must be jQuery object
  constructor: (@form)->
    @setupFileInputField()
    @setupForm()

  getInput: ->
    @form.find('input[data-behavior~="upload"]')

  setupFileInputField: ->
    input = @getInput()

    @statusLabel = $('<div class="status"></div>').insertAfter(input)

    input.fileupload(dataType: 'json', paramName: "images[]", dropZone: @form.find(".file-section")).bind('fileuploaddone', (e, data) =>
      for file, index in data.result.images
        if file.id != null
          $("<input type='hidden' name='post[image_ids][]' value='#{file.id}' />").insertAfter(@statusLabel)
          @uploaded += 1
        else
          @failed += 1
    ).bind(
      'fileuploadadd', @updateStatus
    ).bind(
      'fileuploadalways', @updateStatus
    ).bind(
      'fileuploadstop', @updateStatus
    ).bind(
      'fileuploadstop', @submitForm
    )

  setupForm: ->
    @form.on 'ajax:beforeSend', =>
      if @getInput().fileupload('active') > 0
        @waitingForUpload = true
        return false

  submitForm: (e, data) =>
    if @waitingForUpload && @getInput().fileupload('active') == 0
      @waitingForUpload = false
      @form.submit()

  updateStatus: (e, data) =>
    @statusLabel.html("#{@getInput().fileupload('active')} uploading, #{@uploaded} uploaded, #{@failed} failed")

$ ->
  $('form').each ->
    new ImageUpload($(this))
