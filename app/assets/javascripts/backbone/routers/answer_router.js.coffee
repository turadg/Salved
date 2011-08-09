class Salved.Routers.AnswerRouter extends Backbone.Router
  initialize: (options) ->
    @problem = new Salved.Models.Problem(options.problem)
    initProblemUI()

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
      this.navigate('/1/try')
    
    if step > @problem.attributes.step_count
      this.navigate('/feedback')
    

  start: ->
    this.navigate('/1/try')

  try: (step) ->
    this.checkBounds(step)
    window.currentStep = parseInt(step)
    $('.right-box').hide()
    $('#prompt').show()
    showProblemStep(step - 1)
    $('#work_check').attr('href', '#/'+step+'/check')
    $('#work_help').attr('href', '#/'+step+'/explain')
    
  check: (step) ->
    this.checkBounds(step)
    window.currentStep = parseInt(step)
    $('.right-box').hide()
    $('#work-check').show()
    showProblemStep(step)
  
  explain: (step) ->
    this.checkBounds(step)
    window.currentStep = parseInt(step)
    $('.right-box').hide()
    $('#dialog').show()
    $('#read_explanations').hide();
    showProblemStep(step)
    nextStep = window.currentStep + 1
    nextHash = if nextStep > @problem.attributes.step_count then '/feedback' else '/'+nextStep+'/try'
    $('button.advance_step').click(-> window.location.hash=nextHash)

  feedback: ->
    $('.right-box').hide()
    $('#feedback').show()
    
  summary: ->
    $('.right-box').hide()
    $('#summary').show()
