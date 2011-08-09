class Salved.Routers.ElaborationsRouter extends Backbone.Router
  initialize: (options) ->
    @problem = new Salved.Collections.ElaborationsCollection()
    @elaborations.reset options.elaborations

  routes:
    "/new": "newElaboration"
    "/index": "index"
    "/:id/edit": "edit"
    "/:id": "show"
    ".*": "index"

  newElaboration: ->
    @view = new Salved.Views.Elaborations.NewView(collection: @elaborations)
    $("#elaborations").html(@view.render().el)

  index: ->
    @view = new Salved.Views.Elaborations.IndexView(elaborations: @elaborations)
    $("#elaborations").html(@view.render().el)

  show: (id) ->
    elaboration = @elaborations.get(id)
    
    @view = new Salved.Views.Elaborations.ShowView(model: elaboration)
    $("#elaborations").html(@view.render().el)
    
  edit: (id) ->
    elaboration = @elaborations.get(id)

    @view = new Salved.Views.Elaborations.EditView(model: elaboration)
    $("#elaborations").html(@view.render().el)
  