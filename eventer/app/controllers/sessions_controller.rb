class SessionsController < ApplicationController
  
  def create
    user = User.find_by({user_name: params[:user_name]})  #unique username is better
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to users_path
    else
      flash[:error] = "Incorrect user Name or Password"
      redirect_to '/'
    end
  end
end