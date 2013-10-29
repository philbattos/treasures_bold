require "spec_helper"

describe LandingsController do
  describe "routing" do

    describe "/search_results" do
      it "routes to #index" do
        get("/search_results").should route_to("landings#index")
      end
    end

    describe "/places/:id" do
      it "routes to #show" do
        get("/places/1").should route_to("landings#show", :id => "1")
      end
    end
  end
end
