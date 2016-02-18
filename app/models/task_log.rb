class TaskLog < ActiveRecord::Base
	include Bootsy::Container
	belongs_to :user
	belongs_to :staff
	belongs_to :client
	accepts_nested_attributes_for :client, :update_only => true
	accepts_nested_attributes_for :staff, :update_only => true

	before_save :sum_of_hrs
	before_save :total_time

	validates :client_id, presence: true
	validates :task_title, presence: true
	validates :task_code, presence: true
	validates :task_date, presence: true
	validates :task_description, presence: true
	validates :starting_time, presence: true
	validates :ending_time, presence: true

	def client_name
		"#{client.full_name}"
	end

	def staff_name
		"#{staff.full_name}"
	end


	def completed?
		!completed_at.blank?
	end

	def sum_of_hrs
		sum_value = (self.ending_time - self.starting_time)/3600
		hrs_value = "%.2f" % ((sum_value*60)/60)
		hr_min_value = hrs_value.to_s.split(".").map { |s| s.to_i }
		result_hr = hr_min_value[0].to_s + ":"
		result_min = ((hr_min_value[1]*60)/100).to_s + " Hrs."
		hr_min = result_hr + result_min
	end

	def data_hrs
		sum_value = (self.ending_time - self.starting_time)/3600
		hrs_value = "%.2f" % ((sum_value*60)/60)
	end

	def total_time
		result_time = self.assign_attributes(total_hrs: data_hrs)
	end

	def sum_today
    	total = TaskLog.group("date(created_at)").where(user_id: user.id).sum(:total_hrs).values
  	end

end