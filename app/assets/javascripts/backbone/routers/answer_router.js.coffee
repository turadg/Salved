class Salved.Routers.AnswerRouter extends Backbone.Router
  initialize: (options) ->
    @problem = new Salved.Models.Problem(options.problem)
    @elaboration = new Salved.Models.Elaboration(options.elaboration)
    @steps = new Salved.Collections.StepsCollection(options.steps)
    @steps.url = @elaboration.urlRoot + '/' + @elaboration.id + '/steps'
    
    initProblemUI(@problem)
    console.log "elaboration model url: #{@elaboration.url()}"

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
    showProblemStep(stepIndex - 1)
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
    showProblemStep(stepIndex)
  
  explain: (stepIndex) ->
    this.checkBounds(stepIndex)
    this.update_status()
    window.currentStep = parseInt(stepIndex)
    $('.right-box').hide()
    $('#dialog').show()
    $('#read_explanations').hide();
    showProblemStep(stepIndex)
    nextStep = window.currentStep + 1
    nextHash = if nextStep > @problem.attributes.stepIndex_count then '/feedback' else '/'+nextStep+'/try'
    $('button.advance_stepIndex').click(-> window.location.hash=nextHash)

  feedback: ->
    this.update_status()
    $('.right-box').hide()
    $('#feedback').show()
    
  summary: ->
    this.update_status()
    $('.right-box').hide()
    $('#summary').show()
