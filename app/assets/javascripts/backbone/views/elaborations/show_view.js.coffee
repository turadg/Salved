Salved.Views.Elaborations ||= {}

class Salved.Views.Elaborations.ShowView extends Backbone.View
  template: JST["backbone/templates/elaborations/show"]
   
  render: ->
    $(this.el).html(this.template(this.options.model.toJSON() ))
    return this