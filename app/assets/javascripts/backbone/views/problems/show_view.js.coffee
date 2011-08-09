Salved.Views.Problems ||= {}

class Salved.Views.Problems.ShowView extends Backbone.View
  template: JST["backbone/templates/problems/show"]
   
  render: ->
    $(this.el).html(this.template(this.options.model.toJSON() ))
    return this