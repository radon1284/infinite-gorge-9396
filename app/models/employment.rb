class Employment < ActiveRecord::Base
	belongs_to :staff
	belongs_to :client

	validates_presence_of :staff
	validates_presence_of :client

	has_many :task_logs 

	# validates :multiplier, presence: true
	
	def get_client_name		
		"#{client.full_name}"
	end

	def get_team_leader_name		
		"#{staff.full_name}"
	end

end
