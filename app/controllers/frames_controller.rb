class FramesController < ApplicationController
  before_action :set_game
  before_action :set_frame, only: [:show, :edit, :update, :destroy]

  # GET /frames
  # GET /frames.json
  def index
    @frames = @game.frames.all
  end

  # GET /frames/1
  # GET /frames/1.json
  def show
  end

  # GET /frames/new
  def new
    @frame = @game.frames.new
  end

  # GET /frames/1/edit
  def edit
  end

  # POST /frames
  # POST /frames.json
  def create
    @frame = @game.frames.new(frame_params)

    respond_to do |format|
      # if game_id_correct? && @frame.save
      if @frame.save
        format.html { redirect_to @frame, notice: 'Frame was successfully created.' }
        format.json { render :show, status: :created, location: @frame }
      else
        format.html { render :new }
        format.json { render json: @frame.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /frames/1
  # PATCH/PUT /frames/1.json
  def update
    respond_to do |format|
      if @frame.update(frame_params)
        format.html { redirect_to @frame, notice: 'Frame was successfully updated.' }
        format.json { render :show, status: :ok, location: @frame }
      else
        format.html { render :edit }
        format.json { render json: @frame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frames/1
  # DELETE /frames/1.json
  def destroy
    @frame.destroy
    respond_to do |format|
      format.html { redirect_to game_frames_url(@game), notice: 'Frame was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_game
      @game = Game.find(params[:game_id])
    end
    def set_frame
      @frame = @game.frames.find(params[:id])
    end

    def frame_params
      params.require(:frame).permit(:player_number, :frame_number, :total)
    end

    # def game_id_correct?
    #   params[:game_id] == @frame.game_id
    # end
end
