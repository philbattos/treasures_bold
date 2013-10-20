require "spec_helper"

describe LandingsController do
  describe "routing" do

    it "routes to #index" do
      get("/landings").should route_to("landings#index")
    end

    it "routes to #new" do
      get("/landings/new").should route_to("landings#new")
    end

    it "routes to #show" do
      get("/landings/1").should route_to("landings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/landings/1/edit").should route_to("landings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/landings").should route_to("landings#create")
    end

    it "routes to #update" do
      put("/landings/1").should route_to("landings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/landings/1").should route_to("landings#destroy", :id => "1")
    end

  end
end
