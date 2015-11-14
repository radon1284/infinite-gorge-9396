class DashboardController < ApplicationController
	before_action :set_dashboard, only: [:index, :edit_profile]
	# before_action :set_client_dashboard, only: [:index]

  def index
  	@users = User.all
    @staffs = Staff.all
    @clients = Client.all
    @task_logs = TaskLog.all

    @task_logs_by_date = @task_logs.group_by { |c| c.created_at.to_date }

    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @total_hrs_by_date = TaskLog.where("created_at <= ?", Date.today).sum(:total_hrs)
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
