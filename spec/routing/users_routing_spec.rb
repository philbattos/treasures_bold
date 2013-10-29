require "spec_helper"

describe UsersController do
  describe "routing" do
    describe "users CRUD routes" do

      it "routes to #index" do
        get("/users").should route_to("users#index")
      end

      it "routes to #new" do
        get("/users/new").should route_to("users#new")
      end

      it "routes to #show" do
        get("/users/1").should route_to("users#show", :id => "1")
      end

      it "routes to #edit" do
        get("/users/1/edit").should route_to("users#edit", :id => "1")
      end

      it "routes to #create" do
        # post("/users").should route_to("users#create")
        post("/users").should route_to("devise/registrations#create")
      end

      it "routes to #update" do
        put("/users/1").should route_to("users#update", :id => "1")
      end

      it "routes to #destroy" do
        delete("/users/1").should route_to("users#destroy", :id => "1")
      end
    end

    describe "devise routes" do
      describe "registration routes" do
        it "routes to #new" do
          get("users/sign_up").should route_to("devise/registrations#new")
        end

        it "routes to #cancel" do
          get("users/cancel").should route_to("devise/registrations#cancel")
        end

        it "routes to #edit" do
          get("users/edit").should route_to("devise/registrations#edit")
        end

        it "patch routes to #update" do
          patch("users").should route_to("devise/registrations#update")
        end

        it "put routes to #update" do
          put("users").should route_to("devise/registrations#update")
        end

        it "routes to #destroy" do
          delete("users").should route_to("devise/registrations#destroy")
        end
      end

      describe "session routes" do
        it "routes to #new" do
          get("users/sign_in").should route_to("devise/sessions#new")
        end

        it "routes to #create" do
          post("users/sign_in").should route_to("devise/sessions#create")
        end

        it "routes to #destroy" do
          delete("users/sign_out").should route_to("devise/sessions#destroy")
        end
      end

      describe "password routes" do
        it "routes to #new" do
          get("users/password/new").should route_to("devise/passwords#new")
        end

        it "routes to #create" do
          post("users/password").should route_to("devise/passwords#create")
        end

        it "routes to #edit" do
          get("users/password/edit").should route_to("devise/passwords#edit")
        end

        it "patch routes to #update" do
          patch("users/password").should route_to("devise/passwords#update")
        end

        it "put routes to #update" do
          put("users/password").should route_to("devise/passwords#update")
        end
      end
    end
  end
end
