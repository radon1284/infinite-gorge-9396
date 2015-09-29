class DashboardController < ApplicationController
	before_action :set_dashboard, only: [:index, :edit_profile]
	# before_action :set_client_dashboard, only: [:index]

  def index
  	@users = User.all
    @staffs = Staff.all
    @clients = Client.all
    @task_logs = TaskLog.all
  end

  def edit_profile
  	@users = User.all
    @staffs = Staff.all
    @clients = Client.all
    @task_logs = TaskLog.all
  end

  private
    def set_dashboard
    	if  current_user.role == 'staff'
    		@staff = Staff.find(current_user.meta.id)
    	elsif current_user.role == 'client'
    		@client = Client.find(current_user.meta.id)
    	end
      
    end

end
