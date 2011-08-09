Salved.Views.Problems ||= {}

class Salved.Views.Problems.ProblemView extends Backbone.View
  template: JST["backbone/templates/problems/problem"]
  
  events:
    "click .destroy" : "destroy"
      
  tagName: "tr"
  
  destroy: () ->
    @options.model.destroy()
    this.remove()
    
    return false
    
  render: ->
    $(this.el).html(this.template(this.options.model.toJSON() ))    
    return this