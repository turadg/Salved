class Salved.Models.Step extends Backbone.Model
  paramRoot: 'step'

  defaults:
    justification: null
    selfcheck: null
    understood: null
  
class Salved.Collections.StepsCollection extends Backbone.Collection
  model: Salved.Models.Step
