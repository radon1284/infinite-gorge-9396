
class TaskLog < ActiveRecord::Base
	belongs_to :user
	belongs_to :staff
	has_many :client
	accepts_nested_attributes_for :client, :update_only => true

	before_save :sum_of_hrs
	before_save :total_time

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
    	TaskLog.where("created_at <= ?", Date.today).sum(:total_hrs)
  	end

end
