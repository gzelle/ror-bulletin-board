class BoardthreadsController < ApplicationController
  before_action :set_boardthread, only: [:show, :edit, :update, :destroy]
  before_action :block_banned_users, except: [:index, :show]
  before_action :check_owner, only: [:edit, :update, :destroy]

  # GET /boardthreads
  # GET /boardthreads.json
  def index
    @board = Board.find(params[:board_id])
    @boardthreads = @board.boardthreads.paginate(page: params[:page], per_page: 5)
  end

  # GET /boardthreads/1
  # GET /boardthreads/1.json
  def show
    @boardthread = Boardthread.find(params[:id])
    @post = @boardthread.posts.build
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
        format.html { redirect_to board_path(@board.id), notice: 'Boardthread was successfully created.' }
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

  def managethread
    boardthread = Boardthread.find(params[:id])
    if current_user.moderator? || current_user.administrator?

      if boardthread.unlocked?
        respond_to do |format|
          if boardthread.lock(boardthread)
            format.html { redirect_to boardthread_path, notice: 'Thread was successfully locked.' }
            format.json { render :show, status: :ok, location: @boardthread }
          end
        end

      else
        respond_to do |format|
          if boardthread.unlock(boardthread)
            format.html { redirect_to boardthread_path, notice: 'Thread was successfully unlocked.' }
            format.json { render :show, status: :ok, location: @boardthread }
          end
        end
      end

    else
      flash.now[:notice] = "You have no right to block threads."
    end
  end

  def block_banned_users
    if current_user.banned?
      if action_name == "new" || action_name == "create"
        @board = Board.find(params[:board_id])
      else
        @boardthread = Boardthread.find(params[:id])
        @board = Board.find(@boardthread.board_id)
      end
      redirect_to board_path(@board.id), notice: "You are banned from managing threads.\nContact a moderator or administrator." 
    end
  end

  def check_owner
    boardthread = Boardthread.find(params[:id])
    user = User.find(boardthread.user_id)

    if current_user.poster? && current_user != user
      redirect_to board_path(@boardthread.board_id), notice: "You can't manage threads that aren't yours." 
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
      params.require(:boardthread).permit(:title, :status, :threadtype, :thread_count, :board_id, :user_id)
    end

end
