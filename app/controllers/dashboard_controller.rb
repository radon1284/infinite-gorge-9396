class DashboardController < ApplicationController
  before_action :set_dashboard, only: [:index, :reports]
  before_action :set_user, only: [:edit_profile]
  before_filter :authenticate_user!
  # before_action :set_client_dashboard, only: [:index]

  def index
    @users = User.all
    @staffs = Staff.includes(:clients).includes(:task_logs).all
    @clients = Client.all
    @task_logs = TaskLog.all

    # For Manager and admin
    @list_of_admins = Staff.joins(:user).includes(:clients).includes(:task_logs).where("role = '0'").page(params[:page]).per_page(10)

    @list_of_managers = Staff.joins(:user).includes(:clients).includes(:task_logs).where("role = '1'").page(params[:page]).per_page(10)

    @list_of_teamleads = Staff.joins(:user).includes(:clients).includes(:task_logs).where("role = '2'").page(params[:page]).per_page(10)

    @list_of_staffs = Staff.joins(:user).includes(:clients).includes(:task_logs).where("role = '4'").page(params[:page]).per_page(10)



    # For Team Leader
    @teamleads = Staff.joins(:user).includes(:clients).includes(:task_logs).where("role = '4'").where(team_leader_id: current_user)


    @task_logs_by_date = @task_logs.group_by { |c| c.created_at.to_date }

    @date = params[:date] ? Date.parse(params[:date]) : Date.today



    @dates = Date.today
    @time_today = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_day, @dates.end_of_day).select("SUM(task_logs.total_hrs) AS time_today").where(user_id: current_user)
    # @by_day = ("%.2f" % @time_today).to_s.split(".").map { |s| s.to_i }
    # @total_today = @by_day[0].to_s + ":" + ((@by_day[1]*60)/100).to_s + " Hrs."

    @time_month = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_month, @dates.end_of_month).sum('total_hrs')
    @by_month = ("%.2f" % @time_month).to_s.split(".").map { |s| s.to_i }
    @total_month = @by_month[0].to_s + ":" + ((@by_month[1]*60)/100).to_s + " Hrs."

    if  current_user.role == 'staff'
      @today = Date.today

      # Daily total work per staff
      @total_this_daily = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_day, @dates.end_of_day).where(user_id: @staff.user.id).sum(:total_hrs)
      @calculate_daily = ("%.2f" % @total_this_daily).to_s.split(".").map { |s| s.to_i }
      @total_worked_daily = @calculate_daily[0].to_s + ":" + ((@calculate_daily[1]*60)/100).to_s + " Hrs."

      # weekly total work per staff
      @total_this_week = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_week(start_day = :monday), @dates.end_of_week(end_day = :sunday)).where(user_id: @staff.user.id).sum(:total_hrs)
      @calculate_week = ("%.2f" % @total_this_week).to_s.split(".").map { |s| s.to_i }
      @total_worked_this_week = @calculate_week[0].to_s + ":" + ((@calculate_week[1]*60)/100).to_s + " Hrs."


      # monthly total work per staff
      @total_this_month = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_month, @dates.end_of_month).where(user_id: @staff.user.id).sum(:total_hrs)
      @calculate_month = ("%.2f" % @total_this_month).to_s.split(".").map { |s| s.to_i }
      @total_worked_this_month = @calculate_month[0].to_s + ":" + ((@calculate_month[1]*60)/100).to_s + " Hrs."

      # time total work per staff
      @all_staff_time = TaskLog.includes(:staff).where(user_id: @staff.user.id).sum(:total_hrs)
      @by_all_time = ("%.2f" % @all_staff_time).to_s.split(".").map { |s| s.to_i }
      @total_all_time = @by_all_time[0].to_s + ":" + ((@by_all_time[1]*60)/100).to_s + " Hrs."
    end



    @today = Date.today

    @total_time_today = TaskLog.joins(:client).select("clients.*, SUM(task_logs.total_hrs) AS time_today").group("clients.id").where(user_id: current_user)


    @hrs_all_time = TaskLog.joins(:client).select("clients.*, SUM(task_logs.total_hrs) AS all_time").group("clients.id").where(user_id: current_user)

    @hrs_by_client = TaskLog.joins(:client).select("clients.*, SUM(task_logs.total_hrs) AS hrs_this_month").group("clients.id").where(user_id: current_user)

    if  current_user.role == 'client'
      @hrs_staff_by_client = TaskLog.joins(:staff).joins(:client).joins(:user).select("staffs.full_name AS full_names").select("staffs.position AS positions").select("users.email AS emails").select("clients.*, SUM(task_logs.total_hrs) AS today").group("staffs.id, users.id, clients.id").where(client_id: @client.id)
    end
    
  end

  def edit_profile
    @users = User.all
    @staffs = Staff.all
    @clients = Client.all
    @task_logs = TaskLog.all

    

  end

  def reports

    @dates = DateTime.now.utc
    @time_today = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_day, @dates.end_of_day).where.not(completed_at: '').sum('total_hrs')
    @by_day = ("%.2f" % @time_today).to_s.split(".").map { |s| s.to_i }
    @total_today = @by_day[0].to_s + ":" + ((@by_day[1]*60)/100).to_s + " Hrs."


    @time_week = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_week(start_day = :monday), @dates.end_of_week(end_day = :sunday)).where.not(completed_at: '').sum('total_hrs')
    @by_week = ("%.2f" % @time_week).to_s.split(".").map { |s| s.to_i }
    @total_week = @by_week[0].to_s + ":" + ((@by_week[1]*60)/100).to_s + " Hrs."


    @time_month = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_month, @dates.end_of_month).where.not(completed_at: '').sum('total_hrs')
    @by_month = ("%.2f" % @time_month).to_s.split(".").map { |s| s.to_i }
    @total_month = @by_month[0].to_s + ":" + ((@by_month[1]*60)/100).to_s + " Hrs."

    @hrs_staff_by_client = TaskLog.joins(:staff).joins(:client).joins(:user).select("staffs.full_name AS full_names").select("staffs.position AS positions").select("clients.full_name AS client_names").select("users.email AS emails").select("clients.*, SUM(task_logs.total_hrs) AS today").group("staffs.id, users.id, clients.id")

    @week_start = @dates.beginning_of_week(start_day = :monday)

    @week_end = @dates.end_of_week(end_day = :sunday)

    @days_count = (@week_start..@week_end)


    @admin_count = User.where("role = '0'").count
    @manager_count = User.where("role = '1'").count
    @teamleads_count = User.where("role = '2'").count
    @clients_count = User.where("role = '3'").count
    @staffs_count = User.where("role = '4'").count

    # @half_mnths = TaskLog.group('date(created_at)').having("date(created_at) > ?", Date.today - 14).sum(:total_hrs)

    summary = TaskLog.group('date(created_at)').sum(:total_hrs).to_a
    @past_two_weeks = ((Date.today - 14).. Date.today)

    @half_mnths =Hash[*@past_two_weeks.map(&:to_s).product([0.0]).flatten].merge Hash[*summary.flatten]

    @half_mnths.to_a

  end

  private
    def set_dashboard
      if  current_user.role == 'staff'
        @staff = Staff.find(current_user.meta.id)
      elsif current_user.role == 'client'
        @client = Client.find(current_user.meta.id)
      end
      
    end

  def set_user
      @user = User.find(current_user.id)
  end

  def user_params
      params.require(:user).permit(:email, :password, :role)
  end

end