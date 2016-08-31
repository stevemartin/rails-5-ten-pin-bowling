require "rails_helper"

RSpec.describe FramesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/games/1/frames").to route_to("frames#index", game_id: "1")
    end

    it "routes to #new" do
      expect(:get => "/games/1/frames/new").to route_to("frames#new", game_id: "1")
    end

    it "routes to #show" do
      expect(:get => "/games/1/frames/1").to route_to("frames#show", game_id: "1", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/games/1/frames/1/edit").to route_to("frames#edit", game_id: "1", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/games/1/frames").to route_to("frames#create", game_id: "1" )
    end

    it "routes to #update via PUT" do
      expect(:put => "/games/1/frames/1").to route_to("frames#update", game_id: "1", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/games/1/frames/1").to route_to("frames#update", game_id: "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/games/1/frames/1").to route_to("frames#destroy", game_id: "1", :id => "1")
    end

  end
end
