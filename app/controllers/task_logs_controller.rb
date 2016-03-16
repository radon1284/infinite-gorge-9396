class TaskLogsController < ApplicationController
  before_action :set_task_log, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /task_logs
  # GET /task_logs.json
  def index
    @users = User.all
    @staffs = Staff.all
    @clients = Client.all

    @task_logs_unapprove = TaskLog.includes(:client).includes(:staff).where(completed_at: nil).page(params[:page]).per_page(10).order(created_at: 'DESC')

    @task_logs_approve = TaskLog.includes(:client).includes(:staff).page(params[:page]).per_page(10).order(completed_at: 'DESC')

    @task_logs_by_date = @task_logs.group_by { |c| c.created_at.to_date }

    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    # @total_hrs_by_date = TaskLog.where("created_at <= ?", Date.today).sum(:total_hrs)
    
    # @total_hrs_by_date = TaskLog.sum(:total_hrs)
    @total_hrs_by_date = @task_logs.group_by { |c| c.created_at.to_date }.sum(:total_hrs)

    if  current_user.role == 'staff'
          @dates = DateTime.now.utc

          # Daily total work per staff
          @total_this_daily = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_day, @dates.end_of_day).where(user_id: current_user).sum(:total_hrs)
          @calculate_daily = ("%.2f" % @total_this_daily).to_s.split(".").map { |s| s.to_i }
          @total_worked_daily = @calculate_daily[0].to_s + ":" + ((@calculate_daily[1]*60)/100).to_s + " Hrs."

          # weekly total work per staff
          @total_this_week = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_week(start_day = :monday), @dates.end_of_week(end_day = :sunday)).where(user_id: current_user).sum(:total_hrs)
          @calculate_week = ("%.2f" % @total_this_week).to_s.split(".").map { |s| s.to_i }
          @total_worked_this_week = @calculate_week[0].to_s + ":" + ((@calculate_week[1]*60)/100).to_s + " Hrs."


          # monthly total work per staff
          @total_this_month = TaskLog.where('created_at >= ? and created_at <= ?', @dates.beginning_of_month, @dates.end_of_month).where(user_id: current_user).sum(:total_hrs)
          @calculate_month = ("%.2f" % @total_this_month).to_s.split(".").map { |s| s.to_i }
          @total_worked_this_month = @calculate_month[0].to_s + ":" + ((@calculate_month[1]*60)/100).to_s + " Hrs."

          # # time total work per staff
          # @all_staff_time = TaskLog.includes(:staff).where(user_id: @staff.user.id).sum(:total_hrs)
          # @by_all_time = ("%.2f" % @all_staff_time).to_s.split(".").map { |s| s.to_i }
          # @total_all_time = @by_all_time[0].to_s + ":" + ((@by_all_time[1]*60)/100).to_s + " Hrs."
    end

  end

  # GET /task_logs/1
  # GET /task_logs/1.json
  def show
  end

  # GET /task_logs/new
  def new
    # @task_log = TaskLog.new
    

    @task_log = current_user.task_logs.build
  end

  # GET /task_logs/1/edit
  def edit
  end

  # POST /task_logs
  # POST /task_logs.json
  def create
    # @task_log = TaskLog.new(task_log_params)
     # @post.user_id = current_user.id
    @task_log = current_user.task_logs.build(task_log_params)
    respond_to do |format|
      if @task_log.save
        format.html { redirect_to dashboard_path, notice: 'Task log was successfully created.' }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new }
        format.json { render json: @task_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_logs/1
  # PATCH/PUT /task_logs/1.json
  def update
    respond_to do |format|
      if @task_log.update(task_log_params)
        format.html { redirect_to @task_log, notice: 'Task log was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_log }
      else
        format.html { render :edit }
        format.json { render json: @task_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_logs/1
  # DELETE /task_logs/1.json
  def destroy
    @task_log.destroy
    respond_to do |format|
      format.html { redirect_to task_logs_url, notice: 'Task log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def complete
    respond_to do |format|
      if @task_log.update_attribute(:completed_at, Time.now)
        format.html { redirect_to action: "index", notice: 'Task log was successfully Approved.'}
        format.json { render :index, status: :ok, location: @task_log }
      else
        format.html { render :edit }
        format.json { render json: @task_log.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_log
      @task_log = TaskLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_log_params
      params.require(:task_log).permit(:task_title, :multiplier, :task_code, :task_description, :task_date, :bootsy_image_gallery_id, :starting_time, :ending_time, :total_hrs, :staff_id, :client_id )
    end
    
end
