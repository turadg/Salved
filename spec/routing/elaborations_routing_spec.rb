require "spec_helper"

describe ElaborationsController do
  describe "routing" do

    it "routes to #index" do
      get("/elaborations").should route_to("elaborations#index")
    end

    it "routes to #new" do
      get("/elaborations/new").should route_to("elaborations#new")
    end

    it "routes to #show" do
      get("/elaborations/1").should route_to("elaborations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/elaborations/1/edit").should route_to("elaborations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/elaborations").should route_to("elaborations#create")
    end

    it "routes to #update" do
      put("/elaborations/1").should route_to("elaborations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/elaborations/1").should route_to("elaborations#destroy", :id => "1")
    end

  end
end
