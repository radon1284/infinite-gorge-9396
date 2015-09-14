class Client < ActiveRecord::Base

	 has_one :user, as: :meta, dependent: :destroy
	 accepts_nested_attributes_for :user, :update_only => true
end
