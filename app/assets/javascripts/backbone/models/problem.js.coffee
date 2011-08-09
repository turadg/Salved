class Salved.Models.Problem extends Backbone.Model
  paramRoot: 'problem'

  defaults:
    label: null
    step_count: null
  
class Salved.Collections.ProblemsCollection extends Backbone.Collection
  model: Salved.Models.Problem
  url: '/problems'