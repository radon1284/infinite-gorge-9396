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

    @today = Date.today
    @total_time_today = TaskLog.joins(:client).select("clients.*, SUM(task_logs.total_hrs) AS time_today").group("@today").where(user_id: current_user)

    @hrs_all_time = TaskLog.joins(:client).select("clients.*, SUM(task_logs.total_hrs) AS all_time").group("@today").where(user_id: current_user)

    @hrs_by_client = TaskLog.joins(:client).select("clients.*, SUM(task_logs.total_hrs) AS hrs_this_month").group("clients.id").where(user_id: current_user)

    @hrs_by_staff = TaskLog.joins(:staff).joins(:client).joins(:user).select("staffs.full_name AS full_names").select("staffs.position AS positions").select("users.email AS emails").group("staffs.id").where(user_id: current_user)

    @name = current_user.meta.full_name.split(" ").map { |s| s.to_s }
    @first_name = "#{@name[0].to_s}"


    @dates = DateTime.now.utc
    @time_today = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_day, @dates.end_of_day).where(user_id: current_user).sum('total_hrs')
    @by_day = ("%.2f" % @time_today).to_s.split(".").map { |s| s.to_i }
    @total_today = @by_day[0].to_s + ":" + ((@by_day[1]*60)/100).to_s + " Hrs."


    @time_week = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_week(start_day = :monday), @dates.end_of_week(end_day = :sunday)).where(user_id: current_user).sum('total_hrs')
    @by_week = ("%.2f" % @time_week).to_s.split(".").map { |s| s.to_i }
    @total_week = @by_week[0].to_s + ":" + ((@by_week[1]*60)/100).to_s + " Hrs."


    @time_month = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_month, @dates.end_of_month).where(user_id: current_user).sum('total_hrs')
    @by_month = ("%.2f" % @time_month).to_s.split(".").map { |s| s.to_i }
    @total_month = @by_month[0].to_s + ":" + ((@by_month[1]*60)/100).to_s + " Hrs."

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
