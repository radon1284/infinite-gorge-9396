class Credit < ActiveRecord::Base
  belongs_to :client

  validates :credits, presence: true

  def completed?
  	!completed_at.blank?
  end
end
