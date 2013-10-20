require "spec_helper"

describe MiningsController do
  describe "routing" do

    it "routes to #index" do
      get("/minings").should route_to("minings#index")
    end

    it "routes to #new" do
      get("/minings/new").should route_to("minings#new")
    end

    it "routes to #show" do
      get("/minings/1").should route_to("minings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/minings/1/edit").should route_to("minings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/minings").should route_to("minings#create")
    end

    it "routes to #update" do
      put("/minings/1").should route_to("minings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/minings/1").should route_to("minings#destroy", :id => "1")
    end

  end
end
