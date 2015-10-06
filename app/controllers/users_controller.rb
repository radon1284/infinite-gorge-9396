class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    if user_signed_in? && current_user.role == 'admin'
    	@users = User.all
    	@staffs = Staff.all
    	@clients = Client.all
      @task_logs = TaskLog.all

      # @task_logs_by_date = @task_logs.group_by { |c| c.created_at.to_date }
      # @total_hrs = @task_logs.sum(:total_hrs)
      # @hr_min_value = @total_hrs.to_s.split(".").map { |s| s.to_i }
      # @result_hr = @hr_min_value[0].to_s + ":"
      # @result_min = (((@hr_min_value[1])*60)/100).to_s + " Hrs."
      # @hr_min = @result_hr + @result_min
    else
      redirect_to dashboard_path
    end

  end

  def show
  end

  def new
  	if user_signed_in?
      redirect_to dashboard_path
    else
      redirect_to url_path
    end
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
