class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        current_user = @user
        format.html { redirect_to sign_in_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        flash.now[:error] = @user.errors.full_messages[0]
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @user.password = @user.password
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def manageuser
    user = User.find(params[:id])
    if current_user.moderator? || current_user.administrator?

      if current_user != user

        if !current_user.banned?
      
          if user.normal?
            respond_to do |format|
              if current_user.ban(user)
                format.html { redirect_to user_path, notice: 'User was successfully banned.' }
                format.json { render :show, status: :ok, location: @user }
              end
            end

          else
            respond_to do |format|
              if current_user.unban(user)
                format.html { redirect_to user_path, notice: 'User was successfully unbanned.' }
                format.json { render :show, status: :ok, location: @user }
              end
            end
          end

        else
          flash.now[:notice] = "You are banned and lost admin/mod priveleges.\nContact other administrators."
        end
        
      else
        flash.now[:notice] = "You cannot ban yourself."
      end

    else
      flash.now[:notice] = "You have no right to ban users."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:avatar, :name, :email, :password, :about, :birthdate, :hometown, :present_location, :role, :status, :post_count)
    end

end
