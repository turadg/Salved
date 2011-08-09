Salved.Views.Problems ||= {}

class Salved.Views.Problems.EditView extends Backbone.View
  template: JST["backbone/templates/problems/edit"]
  
  events:
    "submit #edit-problem": "update"
    
  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    @options.model.save(null,
      success:(model) =>
        @options.model = model
        window.location.hash = "/#{@options.model.id}"
    )
    
  render: ->
    $(this.el).html(this.template(@options.model.toJSON() ))
    
    this.$("form").backboneLink(@options.model)
    
    return this