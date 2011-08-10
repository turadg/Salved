class Salved.Routers.AnswerRouter extends Backbone.Router
  initialize: (options) ->
    @problem = new Salved.Models.Problem(options.problem)
    @elaboration = new Salved.Models.Elaboration(options.elaboration)
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
  checkBounds: (step) ->
    step = parseInt(step)
    if step < 1
      this.navigate('/1/try', true)
    
    if step > @problem.attributes.step_count
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

  try: (step) ->
    this.checkBounds(step)
    this.update_status()
    window.currentStep = parseInt(step)
    $('.right-box').hide()
    $('#prompt').show()
    showProblemStep(step - 1)
    $('#work_check').attr('href', '#/'+step+'/check')
    $('#work_help').attr('href', '#/'+step+'/explain')
    
  check: (step) ->
    this.checkBounds(step)
    this.update_status()
    window.currentStep = parseInt(step)
    $('.right-box').hide()
    $('#work-check').show()
    showProblemStep(step)
  
  explain: (step) ->
    this.checkBounds(step)
    this.update_status()
    window.currentStep = parseInt(step)
    $('.right-box').hide()
    $('#dialog').show()
    $('#read_explanations').hide();
    showProblemStep(step)
    nextStep = window.currentStep + 1
    nextHash = if nextStep > @problem.attributes.step_count then '/feedback' else '/'+nextStep+'/try'
    $('button.advance_step').click(-> window.location.hash=nextHash)

  feedback: ->
    this.update_status()
    $('.right-box').hide()
    $('#feedback').show()
    
  summary: ->
    this.update_status()
    $('.right-box').hide()
    $('#summary').show()
