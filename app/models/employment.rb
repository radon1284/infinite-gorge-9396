class Employment < ActiveRecord::Base
	belongs_to :staff
	belongs_to :client

	validates_presence_of :staff
	validates_presence_of :client
	
	def get_client_name		
		"#{client.full_name}"
	end

end
