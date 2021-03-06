require 'pry'
class UsersController < ApplicationController

before_action :authenticate, except: [:new, :create]

	def index
		@users =User.all
	end

	def new
		@user =User.new
	end

	def create
		@user = User.create(user_params)
		if @user.save
		 session[:user_id] = @user.id
		 redirect_to events_path
		else
		 flash[:error] = "There was error creating your profile"
		 render template: "welcome/index"
		end
	end

	def show
		@user = User.find(params[:id])
		@user_events = @user.events
		if session[:user_id] != @user.id
			@show_buttons = false
		else 
			@show_buttons = true
		end
		
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update_attribute(:user_name, params["user"]["user_name"])
		@user.update_attribute(:about_me, params["user"]["about_me"])
		@user.update_attribute(:twitter, params["user"]["twitter"])
		@user.update_attribute(:avatar, params["user"]["avatar"])
		redirect_to user_path(@user)

		# if @user.update_attributes(user_params)
		# 	 #if update succeeeds, redirect to user path
		# 	 redirect_to user_path(@user)

		# else
		# 		#if update fails, redirect to edit form
		# 	render('edit')
		# end

	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		session[:user_id] = nil
		redirect_to "/"

	end

	private
	def user_params
		params.require(:user).permit(:user_name, :password, :password_confirmation, :about_me, :twitter, :avatar)
	end
end