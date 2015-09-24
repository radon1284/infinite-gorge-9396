class Employment < ActiveRecord::Base
	belongs_to :staff
	belongs_to :client

	validates_presence_of :staff
	validates_presence_of :client

	# accepts_nested_attributes_for :staff
	# accepts_nested_attributes_for :client
	


end
