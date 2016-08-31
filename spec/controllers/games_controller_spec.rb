require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  let(:valid_attributes) {
    { players: 4}
  }

  let(:invalid_attributes) {
    { players: 5}
  }

  let(:valid_session) { {} }

  let(:game) { Game.create! valid_attributes }

  describe "GET #index" do
    it "assigns all games as @games" do
      get :index, params: {}, session: valid_session
      expect(assigns(:games)).to eq([game])
    end
  end

  describe "GET #show" do
    it "assigns the requested game as @game" do
      get :show, params: {id: game.to_param}, session: valid_session
      expect(assigns(:game)).to eq(game)
    end
  end

  describe "GET #new" do
    it "assigns a new game as @game" do
      get :new, params: {}, session: valid_session
      expect(assigns(:game)).to be_a_new(Game)
    end
  end

  describe "GET #edit" do
    it "assigns the requested game as @game" do
      get :edit, params: {id: game.to_param}, session: valid_session
      expect(assigns(:game)).to eq(game)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Game" do
        expect {
          post :create, params: {game: valid_attributes}, session: valid_session
        }.to change(Game, :count).by(1)
      end

      it "assigns a newly created game as @game" do
        post :create, params: {game: valid_attributes}, session: valid_session
        expect(assigns(:game)).to be_a(Game)
        expect(assigns(:game)).to be_persisted
      end

      it 'seeds the session with game variables' do
        post :create, params: {game: valid_attributes}, session: valid_session
        expect(session[:frame]).to eq(1)
        expect(session[:player]).to eq(1)
        expect(session[:shot_number]).to eq(1)
      end

      it "redirects to the created game" do
        post :create, params: {game: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Game.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved game as @game" do
        post :create, params: {game: invalid_attributes}, session: valid_session
        expect(assigns(:game)).to be_a_new(Game)
      end

      it "re-renders the 'new' template" do
        post :create, params: {game: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { shots_attributes: [{ number: 2 , frame: 1, player: 1, pins: 1 }] }
      }

      let(:valid_attributes) {
        { players: 4}
      }

      it "updates the requested game" do
        put :update, params: {id: game.to_param, game: new_attributes}, session: valid_session
        game.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested game as @game" do
        put :update, params: {id: game.to_param, game: new_attributes}, session: valid_session
        expect(assigns(:game)).to eq(game)
      end

      it 'assigns the nested shot' do
        expect {
          post :update, params: {id: game.to_param, game: new_attributes}, session: valid_session
        }.to change(Shot, :count).by(1)
      end

      it "updates the dynamic game variables in the session" do
        put :update, params: {id: game.to_param, game: new_attributes}, session: valid_session
        expect(session[:frame]).to eq(1)
        expect(session[:player]).to eq(2)
        expect(session[:shot_number]).to eq(1)
      end

      it "redirects to the game" do
        put :update, params: {id: game.to_param, game: new_attributes}, session: valid_session
        expect(response).to redirect_to(game)
      end
    end

    context "with invalid params" do
      it "assigns the game as @game" do
        put :update, params: {id: game.to_param, game: invalid_attributes}, session: valid_session
        expect(assigns(:game)).to eq(game)
      end

      it "re-renders the 'edit' template" do
        put :update, params: {id: game.to_param, game: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested game" do
      game = Game.create! valid_attributes
      expect {
        delete :destroy, params: {id: game.to_param}, session: valid_session
      }.to change(Game, :count).by(-1)
    end

    it "redirects to the games list" do
      game = Game.create! valid_attributes
      delete :destroy, params: {id: game.to_param}, session: valid_session
      expect(response).to redirect_to(games_url)
    end
  end

end
