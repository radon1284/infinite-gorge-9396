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
      format.html { redirect_to staffs_url, notice: 'Staff was successfully destroyed.' }
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
      params.require(:staff).permit(:full_name, :position, user_attributes: [ :id, :email, :password , :role])
    end
    def update_staff_params
      params.require(:staff).permit(:full_name, :position, user_attributes: [ :id , :role], client_ids:[])
    end
end
