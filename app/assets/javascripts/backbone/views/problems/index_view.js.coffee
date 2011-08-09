Salved.Views.Problems ||= {}

class Salved.Views.Problems.IndexView extends Backbone.View
  template: JST["backbone/templates/problems/index"]
    
  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render');
    
    @options.problems.bind('reset', this.addAll);
   
  addAll: () ->
    @options.problems.each(this.addOne)
  
  addOne: (problem) ->
    view = new Salved.Views.Problems.ProblemView({model : problem})
    this.$("tbody").append(view.render().el)
       
  render: ->
    $(this.el).html(this.template(problems: this.options.problems.toJSON() ))
    @addAll()
    
    return this