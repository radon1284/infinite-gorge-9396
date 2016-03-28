class Credit < ActiveRecord::Base
  belongs_to :client
  belongs_to :staff

  validates :credits, presence: true

  def completed?
  	!completed_at.blank?
  end
end
