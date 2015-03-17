class UsersController < ApplicationController
  layout 'main'
  
  def index
    @users = User.where(" id != ? ", 0 ).order("points DESC")
    @match = Match.new

    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def show
    @user = User.find(session[:current_user_id])

    respond_to do |format|
      format.html # show.html.erb
      
    end
  end


  def new
    @user = User.new

    respond_to do |format|
      format.html 
      
    end
  end


  def edit
    @user = User.find(params[:id])
  end

 
  def create
    @user = User.new(params[:user])

    if @user.save
      session[:current_user_id] = @user.id
      user= User.find(@user.id)
      redirect_to user
    else
      flash[:error] = "Invalid credentials"
      redirect_to :back

    end
  end


  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end
end
