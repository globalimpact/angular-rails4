class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:create] unless Rails.env.test?


private

  def authenticate_user!
    super unless $disable_authentication
  end


public

  def create
    # Create the user from params
    @user = User.new(params[:user])
    if @user.save
      # Deliver the signup_email
      UserMailer.signup_email(@user).deliver
      redirect_to(@user, :notice => "User created")
    else
      render :action => "new"
    end
  end
  
  def index
      @users = User.all
  end

  def show
      @user = User.find(params[:id])
      
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id]) 
    session[:return_to] = request.referer
  end


  def update
      @user = User.find(params[:id])
      if @user.update_attributes(params.require(:user).permit(:name, :email, :password, :password_confirmation))
        redirect_to @user, :notice => "User was successfully updated."
      else
        render :action => 'edit'
      end
      
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_path, :notice => 'User was successfully deleted.'
      
    end
  end