require 'rails_helper'

RSpec.describe "Shots", type: :request do
  describe "GET /shots" do
    it "works! (now write some real specs)" do
      get shots_path
      expect(response).to have_http_status(200)
    end
  end
end
