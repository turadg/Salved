class Salved.Routers.AnswerRouter extends Backbone.Router
  initialize: (options) ->
    @problem = new Salved.Models.Problem(options.problem)
    @elaboration = new Salved.Models.Elaboration(options.elaboration)
    @steps = new Salved.Collections.StepsCollection(options.steps)
    @steps.url = @elaboration.urlRoot + '/' + @elaboration.id + '/steps'    

    # set up env
    @imageList = this.stepImages(@problem.get('filesPath'), @problem.get('step_count'))
    # start loading all the images
    (new Image()).src=path for path in @imageList
    
    $(document).ready(-> initProblemUI(window.router.recordEvent))

  routes:
    "/:step/try": "try"
    "/:step/check": "check"
    "/:step/explain": "explain"
    "/feedback": "feedback"
    "/summary": "summary"
    ".*": "start"

  # redirect if step number is out of bounds
  checkBounds: (stepIndex) ->
    stepIndex = parseInt(stepIndex)
    if stepIndex < 0
      this.navigate('/0/try', true)
    
    if stepIndex >= @problem.attributes.step_count
      this.navigate('/feedback', true)

  # save status as current hash
  update_status: ->
    @elaboration.set({status: document.location.hash})
    @elaboration.save()
  
  # navigate to the status in the hash
  navigate_on_status: ->
    status = @elaboration.get('status')
    if status.charAt(0)=='#'
      path = status
      console.log("navigating to #{path}")
      this.navigate(path, true)

  start: ->
    this.navigate_on_status()

  try: (stepIndex) ->
    this.checkBounds(stepIndex)
    this.update_status()

    # TODO refactor this as a bound template
    justification = @steps.at(stepIndex).get('justification')
    $('textarea[name=justification]').val(justification)

    window.currentStep = parseInt(stepIndex)
    $('.right-box').hide()
    $('#prompt').show()
    this.showProblemStep(stepIndex)
    $('#work_check').attr('href', '#/'+stepIndex+'/check')
    $('#work_help').attr('href', '#/'+stepIndex+'/explain')
    
  check: (stepIndex) ->
    this.checkBounds(stepIndex)
    this.update_status()
    
    justification = $('textarea[name=justification]').val()
    @steps.at(stepIndex).save({justification: justification})
    
    window.currentStep = parseInt(stepIndex)
    $('.right-box').hide()
    $('#work-check').show()
    this.showProblemStep(window.currentStep+1)
  
  explain: (stepIndex) ->
    this.checkBounds(stepIndex)
    this.update_status()
    window.currentStep = parseInt(stepIndex)
    $('.right-box').hide()
    $('#dialog').show()
    $('#read_explanations').hide();
    this.showProblemStep(window.currentStep+1)
    nextStep = window.currentStep + 1
    nextHash = if nextStep >= @problem.get('step_count') then '/feedback' else '/'+nextStep+'/try'
    $('button.advance_step').click(-> window.router.navigate(nextHash, true))

  feedback: ->
    this.update_status()
    $('.right-box').hide()
    $('#feedback').show()
    
  summary: ->
    this.update_status()
    $('.right-box').hide()
    $('#summary').show()


  showProblemStep: (step) ->
    path = @imageList[step]
    # console.log "showing ", step, " with ", path
    $(document).ready(-> $('#work_shown').attr('src', path) )



  recordEvent: (name, value) ->
    # common: problem_id, currentStep
    data = {'problem_event': {
      'problem_id': @problem.id,
      'step': currentStep,
      'name': name,
      'value': value
    }}
    $.post('/problem_events', data)

  stepImages: (imagePath, count) ->
    # emulate Handlebars in Underscore templating
    _.templateSettings = { interpolate : /\{\{(.+?)\}\}/g  }

    template = _.template(imagePath);
    template({stepIndex : index}) for index in [0..count]
  