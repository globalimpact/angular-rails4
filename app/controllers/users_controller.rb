class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]

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
      authorize! :manage, @user 
  end

  def show
      @user = User.find(params[:id])
      
  end

  def new
    @user = User.new
    
  end

  def edit
    @user = User.find(params[:id])
    
  end


  def update
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        redirect_to action: "index", :flash => { :success => 'User was successfully updated.' }
      else
        render :action => 'edit'
      end
      
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_path, :flash => { :success => 'User was successfully deleted.' }
      authorize! :manage, @user
      
    end
  end