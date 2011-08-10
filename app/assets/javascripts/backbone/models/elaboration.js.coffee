class Salved.Models.Elaboration extends Backbone.Model
  paramRoot: 'elaboration'
  urlRoot: '/elaborations'
  
  defaults:
    status: null
    difficulty: null
    note_to_self: null
    note_to_instructor: null
  
class Salved.Collections.ElaborationsCollection extends Backbone.Collection
  model: Salved.Models.Elaboration
  url: '/elaborations'