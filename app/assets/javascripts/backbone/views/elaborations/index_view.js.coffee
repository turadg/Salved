Salved.Views.Elaborations ||= {}

class Salved.Views.Elaborations.IndexView extends Backbone.View
  template: JST["backbone/templates/elaborations/index"]
    
  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render');
    
    @options.elaborations.bind('reset', this.addAll);
   
  addAll: () ->
    @options.elaborations.each(this.addOne)
  
  addOne: (elaboration) ->
    view = new Salved.Views.Elaborations.ElaborationView({model : elaboration})
    this.$("tbody").append(view.render().el)
       
  render: ->
    $(this.el).html(this.template(elaborations: this.options.elaborations.toJSON() ))
    @addAll()
    
    return this