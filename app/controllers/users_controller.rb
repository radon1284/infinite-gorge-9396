class UsersController < ApplicationController

  def index
  	@users = User.all
  	@staffs = Staff.all
  	@clients = Client.all
  end

  def show
  end

  def new
  	@user = User.new
  end



  def edit
  end

  def create
  end


  def update
  end

  private

  def set_user
      @user = User.find(params[:id])
    end

  def user_params
      params.require(:user).permit(:email, :password, :role)
  end
end
