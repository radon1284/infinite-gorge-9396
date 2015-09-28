class DashboardController < ApplicationController

  def index
  	@users = User.all
    @staffs = Staff.all
    @clients = Client.all
    @task_logs = TaskLog.all

  end

end
