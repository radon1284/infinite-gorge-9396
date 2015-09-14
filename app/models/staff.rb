class Staff < ActiveRecord::Base

	has_one :user, as: :meta, dependent: :destroy
	accepts_nested_attributes_for :user, :update_only => true

	has_many :employments
	has_many :client, :through => :employments
end
