class PagesController < ApplicationController
	# before_action :set_staff, only: [:dashboard, :home]

  def home
  end
  
  # def dashboard
  #   @users = User.all
  #   @staffs = Staff.all
  #   @clients = Client.all
  #   @task_logs = TaskLog.all

  # end

  private

    # def set_staff
    #   @staff = Staff.find(params[:id])
    # end
    
    # def staff_params
    #   params.require(:staff).permit(:full_name, :position, user_attributes: [ :id, :email, :password , :role])
    # end

end
