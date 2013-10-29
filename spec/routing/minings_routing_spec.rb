require "spec_helper"

describe SearchesController do
  describe "routing" do
    
    describe "home page" do
      describe "/" do
        it "routes to #new" do
          get("/").should route_to "searches#new"
        end
      end

      describe "/search" do
        it "routes to #new" do
          get("/search").should route_to "searches#new"
        end
      end
    end

    describe "new searches" do
      it "routes to #create" do
        post("/searches").should route_to "searches#create"
      end
    end

    describe "/minings" do
      it "routes to #index" do
        get("/minings").should route_to "searches#index"
      end
    end
  end
end
