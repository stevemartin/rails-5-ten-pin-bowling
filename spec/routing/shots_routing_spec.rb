require "rails_helper"

RSpec.describe ShotsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shots").to route_to("shots#index")
    end

    it "routes to #new" do
      expect(:get => "/shots/new").to route_to("shots#new")
    end

    it "routes to #show" do
      expect(:get => "/shots/1").to route_to("shots#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shots/1/edit").to route_to("shots#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shots").to route_to("shots#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/shots/1").to route_to("shots#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/shots/1").to route_to("shots#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shots/1").to route_to("shots#destroy", :id => "1")
    end

  end
end
