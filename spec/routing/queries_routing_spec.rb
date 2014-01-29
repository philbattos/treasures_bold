require "spec_helper"

describe QueriesController do
  describe "routing" do
    
    describe "home page" do
      describe "/" do
        it "routes to #new" do
          get("/").should route_to "queries#new"
        end
      end

      describe "/search" do
        it "routes to #new" do
          get("/search").should route_to "queries#new"
        end
      end
    end

    describe "new queries" do
      it "routes to #create" do
        post("/queries").should route_to "queries#create"
      end
    end

    describe "/minings" do
      it "routes to #index" do
        get("/minings").should route_to "queries#index"
      end
    end
  end
end
