class UsersController < ApplicationController
  def index
  end

  def login
  	@title = "Login"

  end

  def post_login
  	user = User.find_by_login(params[:user][:login])
      if user
          user.password = params[:user][:password]
          if user.password_valid?(params[:user][:password])
            session[:id] = user.id
            session[:name] = user.first_name
            redirect_to(:controller => 'photos', :action => 'index', :id => session[:id])
          else
            redirect_to :back, :flash => {:message =>'Try again'}
          end
      else
          redirect_to :back, :flash => {:message =>'Try again'}
      end
  end

  def logout
  	reset_session
	redirect_to(:action => :login)
  end

  def new
      @title = "Sign Up!"
  end
  

  def create
    @user = User.new(user_params)
    if @user.save then
      redirect_to(:action => :login)
    else
      redirect_to(:back, :flash => {:message => 'Please try again'})
    end
end

private
  def user_params
      return params.require(:user).permit(:first_name,:last_name,:login,:password,:password_confirmation)
  end
end
