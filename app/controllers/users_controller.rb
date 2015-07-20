class UsersController < ApplicationController

  def show
  end

  def edit
  end

  def new
    @user = User.new
  end

  def create
  	@user = User.create(user_params)
  		if @user.save
  			session[:user_id] = @user.id
  			flash[:success] = "You are now logged in!"
  			redirect_to user_teams_path(@user)
  		else
  			flash[:notice] = "Create Failed!"
  			render :signup
  		end
   end
   
end
