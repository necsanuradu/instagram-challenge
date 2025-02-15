class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    if session[:user_id]
      @users = User.where(id: session[:user_id].to_i)
      redirect_to home_path
    else
      @users = []
      redirect_to home_path
    end
  end

  # GET /users/1 or /users/1.json
  def show
    redirect_to home_path
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    redirect_to home_path
  end

  def createy
    # or attch an avatar to an existing user
    # user.avatar.attach(params[:avatar])

    user = User.create!(user_params)
    session[:user_id] = user.id
    redirect_to home_path
  end

  # POST /users or /users.json
  def create
    message = 'User was successfully created.'
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: message }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    redirect_to home_path
    message = 'User was successfully updated.'
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: message }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    redirect_to home_path
    message = 'User was successfully destroyed.'
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: message }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    redirect_to home_path
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar)
  end
end
