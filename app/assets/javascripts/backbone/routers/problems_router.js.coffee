class Salved.Routers.ProblemsRouter extends Backbone.Router
  initialize: (options) ->
    @problems = new Salved.Collections.ProblemsCollection()
    @problems.reset options.problems

  routes:
    "/new": "newProblem"
    "/index": "index"
    "/:id/edit": "edit"
    "/:id": "show"
    ".*": "index"

  newProblem: ->
    @view = new Salved.Views.Problems.NewView(collection: @problems)
    $("#problems").html(@view.render().el)

  index: ->
    @view = new Salved.Views.Problems.IndexView(problems: @problems)
    $("#problems").html(@view.render().el)

  show: (id) ->
    problem = @problems.get(id)
    
    @view = new Salved.Views.Problems.ShowView(model: problem)
    $("#problems").html(@view.render().el)
    
  edit: (id) ->
    problem = @problems.get(id)

    @view = new Salved.Views.Problems.EditView(model: problem)
    $("#problems").html(@view.render().el)
  