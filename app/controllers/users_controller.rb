class UsersController < ApplicationController
  before_action :require_login, only: [:index, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :new]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
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

      if @user.save
        session[:user_id] = @user.id
        redirect_to payments_path
      else
        flash.now[:error] = @user.errors.full_messages
        render :login
        end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      if @user.update(user_params)
        redirect_to payments_path
        flash[:success] = "User updated successfully!"
      else
        flash.now[:error] = @user.errors.full_messages
        render :edit
      end
  end

  def authenticate
    @user = User.authenticate(params[:email], params[:password])
    if @user.present?
      session[:user_id] = @user.id
      redirect_to payments_path
    else
      flash.now[:error] = []
      flash.now[:error] << "Invalid email/password combination"
      render :login
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to :login
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
