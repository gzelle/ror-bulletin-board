class BoardthreadsController < ApplicationController
  before_action :set_boardthread, only: [:show, :edit, :update, :destroy]

  # GET /boardthreads
  # GET /boardthreads.json
  def index
    @board = Board.find(params[:board_id])
    @boardthreads = @board.boardthreads
  end

  # GET /boardthreads/1
  # GET /boardthreads/1.json
  def show
    Boardthread.find(params[:id])
  end

  # GET /boardthreads/new
  def new
    @boardthread = Boardthread.new
  end

  # GET /boardthreads/1/edit
  def edit
    boardthread = Boardthread.find(params[:id])
  end

  # POST /boardthreads
  # POST /boardthreads.json
  def create
    @user = current_user
    @board = Board.find(params[:board_id])
    @boardthread = @board.boardthreads.build(boardthread_params)
    @boardthread.user_id = @user.id

    respond_to do |format|
      if @boardthread.save
        format.html { redirect_to board_boardthreads_path, notice: 'Boardthread was successfully created.' }
        format.json { render :show, status: :created, location: @boardthread }
      else
        format.html { render :new }
        format.json { render json: @boardthread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boardthreads/1
  # PATCH/PUT /boardthreads/1.json
  def update
    boardthread = Boardthread.find(params[:id])

    respond_to do |format|
      if @boardthread.update(boardthread_params)
        format.html { redirect_to @boardthread, notice: 'Boardthread was successfully updated.' }
        format.json { render :show, status: :ok, location: @boardthread }
      else
        format.html { render :edit }
        format.json { render json: @boardthread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boardthreads/1
  # DELETE /boardthreads/1.json
  def destroy
    boardthread = Boardthread.find(params[:id])
    @boardthread.destroy
    respond_to do |format|
      format.html { redirect_to board_boardthreads_path(boardthread.board_id), notice: 'Boardthread was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boardthread
      @boardthread = Boardthread.find(params[:id])
    end

    def set_board
      @board = Board.find(params[:board_id])
    end

    def prepare_boards
      @boards = Board.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boardthread_params
      params.require(:boardthread).permit(:title, :board_id, :user_id)
    end
end
