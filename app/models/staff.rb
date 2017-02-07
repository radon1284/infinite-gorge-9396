class Staff < ActiveRecord::Base

	has_one :user, as: :meta, dependent: :destroy
	accepts_nested_attributes_for :user, :update_only => true

	has_many :task_logs, dependent: :destroy
	has_many :credits, dependent: :destroy

	has_many :employments
	has_many :clients, :through => :employments
	accepts_nested_attributes_for :employments, allow_destroy: true


	def initialized_employments # this is the key method
	    [].tap do |o|
	      Client.all.each do |client|
	        if c = employments.find { |c| c.client_id == client.id }
	          o << c.tap { |c| c.enable ||= true }
	        else
	          o << employments.new(client: client)
	        end
	      end
	    end
	end

	def team_leader_id
	end

	def total_time_today
	end
	def total_time_week
	end
	def total_time_month
	end
end
