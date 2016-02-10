class Client < ActiveRecord::Base

	 has_one :user, as: :meta, dependent: :destroy
	 accepts_nested_attributes_for :user, :update_only => true

	 has_many :employments
	 has_many :staffs, :through => :employments
	 accepts_nested_attributes_for :employments, allow_destroy: true
	 has_many :task_logs

	 validates :full_name, presence: true
	 validates :business_name, presence: true
	 validates :crm_code, presence: true
	 validates :initial_hrs, presence: true


	def total_time_today
		TaskLog.where("created_at <= ?", Date.today).sum(:total_hrs)
		# TaskLog.sum(:total_hrs)
	end

	def total_time_week
	end
	
	def total_time_month
	end

end