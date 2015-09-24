class UsersController < ApplicationController

  def index
  	@users = User.all
  	@staffs = Staff.all
  	@clients = Client.all
    @task_logs = TaskLog.all

    @task_logs_by_date = @task_logs.group_by { |c| c.created_at.to_date }
    

    @total_hrs = @task_logs.sum(:total_hrs)
    @hr_min_value = @total_hrs.to_s.split(".").map { |s| s.to_i }
    @result_hr = @hr_min_value[0].to_s + ":"
    @result_min = (((@hr_min_value[1])*60)/100).to_s + " Hrs."
    @hr_min = @result_hr + @result_min

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
