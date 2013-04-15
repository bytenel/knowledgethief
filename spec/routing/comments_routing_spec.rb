require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #index" do
      get("/rcomments").should route_to("rcomments#index")
    end

    it "routes to #new" do
      get("/rcomments/new").should route_to("rcomments#new")
    end

    it "routes to #show" do
      get("/rcomments/1").should route_to("rcomments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/rcomments/1/edit").should route_to("rcomments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/rcomments").should route_to("rcomments#create")
    end

    it "routes to #update" do
      put("/rcomments/1").should route_to("rcomments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/rcomments/1").should route_to("rcomments#destroy", :id => "1")
    end

  end
end
