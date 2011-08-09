Salved.Views.Elaborations ||= {}

class Salved.Views.Elaborations.ElaborationView extends Backbone.View
  template: JST["backbone/templates/elaborations/elaboration"]
  
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