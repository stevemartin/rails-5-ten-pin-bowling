require 'rails_helper'

RSpec.describe FramesController, type: :controller do

  let(:game) { FactoryGirl.create(:game) }

  let(:valid_attributes) {
    { player_number: 1, frame_number: 1, total: 10 }
  }

  let(:invalid_attributes) {
    { player_number: nil, frame_number: nil, total: nil, plinky: 1 }
  }

  let(:valid_params) {
    { game_id: game.id }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all frames as @frames" do
      frame = game.frames.create! valid_attributes
      get :index, params: valid_params, session: valid_session
      expect(assigns(:frames)).to eq([frame])
    end
  end

  describe "GET #show" do
    it "assigns the requested frame as @frame" do
      frame = game.frames.create! valid_attributes
      get :show, params: {id: frame.to_param, game_id: game.id}, session: valid_session
      expect(assigns(:frame)).to eq(frame)
    end
  end

  describe "GET #new" do
    it "assigns a new frame as @frame" do
      get :new, params: valid_params, session: valid_session
      expect(assigns(:frame)).to be_a_new(Frame)
    end
  end

  describe "GET #edit" do
    it "assigns the requested frame as @frame" do
      frame = game.frames.create! valid_attributes
      get :edit, params: {id: frame.to_param, game_id: game.id}, session: valid_session
      expect(assigns(:frame)).to eq(frame)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Frame" do
        expect {
          post :create, params: {frame: valid_attributes, game_id: game.id}, session: valid_session
        }.to change(Frame, :count).by(1)
      end

      it "assigns a newly created frame as @frame" do
        post :create, params: {frame: valid_attributes, game_id: game.id}, session: valid_session
        expect(assigns(:frame)).to be_a(Frame)
        expect(assigns(:frame)).to be_persisted
      end

      it "redirects to the created frame" do
        post :create, params: {frame: valid_attributes, game_id: game.id}, session: valid_session
        expect(response).to redirect_to(Frame.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved frame as @frame" do
        post :create, params: {frame: invalid_attributes, game_id: game.id}, session: valid_session
        expect(assigns(:frame)).to be_a_new(Frame)
      end

      it "re-renders the 'new' template" do
        post :create, params: {frame: invalid_attributes, game_id: game.id}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { player_number: 2, total: 20 }
      }

      it "updates the requested frame" do
        frame = game.frames.create! valid_attributes
        put :update, params: {id: frame.to_param, frame: new_attributes, game_id: game.id}, session: valid_session
        frame.reload
        expect(frame.player_number).to eq(2)
        expect(frame.total).to eq(20)
      end

      it "assigns the requested frame as @frame" do
        frame = game.frames.create! valid_attributes
        put :update, params: {id: frame.to_param, frame: valid_attributes, game_id: game.id}, session: valid_session
        expect(assigns(:frame)).to eq(frame)
      end

      it "redirects to the frame" do
        frame = game.frames.create! valid_attributes
        put :update, params: {id: frame.to_param, frame: valid_attributes, game_id: game.id}, session: valid_session
        expect(response).to redirect_to(frame)
      end
    end

    context "with invalid params" do
      it "assigns the frame as @frame" do
        frame = game.frames.create! valid_attributes
        put :update, params: {id: frame.to_param, frame: invalid_attributes, game_id: game.id}, session: valid_session
        expect(assigns(:frame)).to eq(frame)
      end

      it "re-renders the 'edit' template" do
        frame = game.frames.create! valid_attributes
        put :update, params: {id: frame.to_param, frame: invalid_attributes, game_id: game.id}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested frame" do
      frame = game.frames.create! valid_attributes
      expect {
        delete :destroy, params: {id: frame.to_param, game_id: game.id}, session: valid_session
      }.to change(Frame, :count).by(-1)
    end

    it "redirects to the frames list" do
      frame = game.frames.create! valid_attributes
      delete :destroy, params: {id: frame.to_param, game_id: game.id}, session: valid_session
      expect(response).to redirect_to(game_frames_url(game))
    end
  end

end
