class Credit < ActiveRecord::Base
  belongs_to :client

  def completed?
  	!completed_at.blank?
  end
end
