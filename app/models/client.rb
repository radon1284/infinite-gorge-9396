class Client < ActiveRecord::Base

	 has_one :user, as: :meta, dependent: :destroy
	 accepts_nested_attributes_for :user, :update_only => true


	 has_many :employments
	 has_many :staffs, :through => :employments
	 accepts_nested_attributes_for :employments, allow_destroy: true
	 belongs_to :task_logs

end
