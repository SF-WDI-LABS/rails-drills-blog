class UsersController < ApplicationController

  before_action :require_login, only: [:show, :edit, :destroy]
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  # GET /users/new
  def new
    @user = User.new
    @title = "Sign up"
  end

  # GET /users/:id
  def show
  end

  # GET /users/:id/edit
  def edit
    @title = 'Edit profile'
  end

  # POST /users
  def create
    @user = User.new user_params
    if @user.valid?
      @user.save
      login @user
      redirect_to @user, flash: { success: "Welcome, #{@user.first_name}!" }
    else
      flash.now[:danger] = "Please fix these errors: #{@user.errors.messages}"
      render :new
    end
  end

  # PATCH /users/:id
  def update
    binding.pry
    if @user.update_attributes user_params
      redirect_to user_path(@user)
    else
      binding.pry
      flash.now[:warning] = "Problems with your changes: #{@user.errors.messages}"
      render :edit
    end
  end

  # DELETE /user/:id
  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :email_confirmation, :password, :password_confirmation)
  end

  def find_user
    @user = User.find params[:id]
  end

end

