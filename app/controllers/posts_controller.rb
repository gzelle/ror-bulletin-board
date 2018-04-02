class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :block_banned_users, except: [:index, :show]
  before_action :check_owner, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @boardthread = Boardthread.find(params[:boardthread_id])
    #@posts = @boardthread.posts.paginate(page: params[:page], per_page: 5)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = current_user
    @boardthread = Boardthread.find(params[:boardthread_id])
    @post = @boardthread.posts.build(post_params)
    @post.user_id = @user.id

    if @boardthread.unlocked?

      respond_to do |format|
        if @post.save
          format.html { redirect_to boardthread_path(@boardthread.id), notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render boardthread_path(@boardthread.id) }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end

    else
      redirect_to boardthread_path(@boardthread.id), notice: "Thread is locked. Contact a mod or administrator." 
    end

  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to boardthread_posts_path(@post.boardthread_id), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def block_banned_users
    if current_user.banned?
      @boardthread = Boardthread.find(params[:boardthread_id])
      redirect_to boardthread_path(@boardthread.id), notice: "You are banned from posting on threads.\nContact a moderator or administrator." 
    end
  end

  def check_owner
    post = Post.find(params[:id])
    user = User.find(post.user_id)
    boardthread = Boardthread.find(post.boardthread_id)

    if current_user.poster? && current_user != user
      redirect_to boardthread_path(boardthread.id), notice: "You can't modify posts that aren't yours." 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_boardthread
      @boardthread = Boardthread.find(params[:boardthread_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:message, :boardthread_id, :user_id)
    end
end
