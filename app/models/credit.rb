class Credit < ActiveRecord::Base
  belongs_to :client
  belongs_to :staff

  has_many :task_logs

  validates :credits, presence: true
  validates :staff_id, presence: true

  def get_staff_name		
		"#{staff.full_name}"
  end

  def total_use_hrs
    TaskLog.where(staff_id: :staff_id ).sum(:total_hrs)  
  end

  def completed?
  	!completed_at.blank?
  end
end
