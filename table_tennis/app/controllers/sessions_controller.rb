class SessionsController < ApplicationController

def new
end

def create
 user= User.authenticate(params[:session])
 if user 
 	session[:current_user_id] = user.id
   redirect_to user
 else
 	flash[:error] = "Authentication Failed, please try again"
   render 'new'
 end
   
end

def destroy
	session[:current_user_id] = nil
	redirect_to root_url, :success => "Logged out!"

end

end
