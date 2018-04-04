require 'will_paginate/array' 

class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :prepare_topics
  before_action :check_admin, except: [:show, :index]

  # GET /boards
  # GET /boards.json
  def index
    @topic = Topic.find(params[:topic_id])
    @boards = @topic.boards
    @boards = Board.order(:sort).all
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    Board.find(params[:id])
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
    board = Board.find(params[:id])
  end

  # POST /boards
  # POST /boards.json
  def create
    @topic = Topic.find(params[:topic_id])
    @board = @topic.boards.build(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to topic_path(@topic.id), notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    board = Board.find(params[:id])
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to root_path, notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy  
    board = Board.find(params[:id])
    @board.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_admin
    if action_name == "new" || action_name == "create"
      topic = Topic.find(params[:topic_id])
    else
      topic = Topic.find(@board.topic_id)
    end


    if !current_user.administrator?
      redirect_to topic_path(@topic.id), notice: "You have no rights to manage boards."
    end

    if current_user.banned?
      redirect_to topic_path(topic.id), notice: "You are banned from managing boards.\nContact other administrators." 
    end

  end

  def update_row_order
    @board = Board.find(board_params[:board_id])
    @board.row_order_position = board_params[:row_order_position]
    @board.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    def set_topic
      @topic = Topic.find(params[:topic_id])
    end

    def prepare_topics
      @topics = Topic.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:photo, :name, :description, :topic_id, :thread_count, :post_count, :position)
    end
end
