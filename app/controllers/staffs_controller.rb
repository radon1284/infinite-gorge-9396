class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /staffs
  # GET /staffs.json
  def index
    if current_user.role == 'admin'
    @staffs = Staff.all
    @task_logs = TaskLog.all
    @task_logs_by_date = @task_logs.group_by { |c| c.created_at.to_date }
    elsif current_user.role == 'manager'
    @staffs = Staff.all
    @task_logs = TaskLog.all

    @task_logs_by_date = @task_logs.group_by { |c| c.created_at.to_date }
    elsif current_user.role == 'team_leader'
        redirect_to dashboard_path
    elsif current_user.role == 'client'
        redirect_to dashboard_path
    else
      redirect_to dashboard_path
    end

  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
    @dates = DateTime.now.utc
    @time_today = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_day, @dates.end_of_day).where(user_id: @staff.id).sum('total_hrs')
    @by_day = ("%.2f" % @time_today).to_s.split(".").map { |s| s.to_i }
    @total_today = @by_day[0].to_s + ":" + ((@by_day[1]*60)/100).to_s + " Hrs."


    @time_week = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_week(start_day = :monday), @dates.end_of_week(end_day = :sunday)).where(user_id: @staff.id).sum('total_hrs')
    @by_week = ("%.2f" % @time_week).to_s.split(".").map { |s| s.to_i }
    @total_week = @by_week[0].to_s + ":" + ((@by_week[1]*60)/100).to_s + " Hrs."


    @time_month = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_month, @dates.end_of_month).where(user_id: @staff.id).sum('total_hrs')
    @by_month = ("%.2f" % @time_month).to_s.split(".").map { |s| s.to_i }
    @total_month = @by_month[0].to_s + ":" + ((@by_month[1]*60)/100).to_s + " Hrs."

    @hrs_by_client = TaskLog.joins(:client).select("clients.*, SUM(task_logs.total_hrs) AS hrs_today").group("clients.id").where(user_id: @staff.id)
  end

  # GET /staffs/new
  def new
    if current_user.role == 'admin'
      @staff = Staff.new
    elsif current_user.role == 'manager'
      @staff = Staff.new
    elsif current_user.role == 'team_leader'
        redirect_to dashboard_path
    elsif current_user.role == 'client'
        redirect_to dashboard_path
    else
      redirect_to dashboard_path
    end
  end

  # GET /staffs/1/edit
  def edit
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    respond_to do |format|
      if @staff.update(update_staff_params)
        format.html { redirect_to @staff, notice: 'Staff was successfully updated.' }
        format.json { render :show, status: :ok, location: @staff }
      else
        format.html { render :edit }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Staff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      params.require(:staff).permit(:full_name, :position, :user_id, :admin_id, :manager_id, :team_leader_id, user_attributes: [ :id, :email, :password , :role, :user_id, :admin_id, :manager_id, :team_leader_id])
    end
    
    def update_staff_params
      params.require(:staff).permit(:full_name, :position, :user_id, :admin_id, :manager_id, :team_leader_id, user_attributes: [ :id , :role, :user_id, :admin_id, :manager_id, :team_leader_id], client_ids:[], employment_attributes:[:multiplier])
    end
end
