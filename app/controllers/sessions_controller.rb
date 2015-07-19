class SessionsController < ApplicationController
 before_action :confirm_logged_in, only: [:home]
 before_action :prevent_login_signup, only: [:login]

  def create
  	@user = User.create(user_params)
  		if @user.save
  			session[:user_id] = @user.id
  			flash[:success] = "You are now logged in!"
  			redirect_to home_path
  		else
  			flash[:notice] = "Create Failed!"
  			render :signup
  		end
  end

  def signup
    @user = User.new
  end

  def login
    # render :login
  end

  def attempt_login
  	if params[:username].present? && params[:password].present?
  		found_user = User.where(username: params[:username]).first
  		if found_user
  			authorized_user = found_user.authenticate(params[:password])
  			if authorized_user
  				session[:user_id] = authorized_user.id
  				flash[:success] = "You are now logged in!"
  				redirect_to home_path
  			else
  				redirect_to login_path, notice: "Login Failed."
  			end
  		end
  	end
  end

  def logout
      session[:user_id] = nil
      flash[:notice] = "Logged out"
      redirect_to login_path
  end

  def home
    @teams = Team.all
  end

  private
  def user_params
  	params.require(:user).permit(:username, :password, :password_digest)
  end

end
