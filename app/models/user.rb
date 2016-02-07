class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :task_logs
         
  belongs_to :meta, polymorphic: true

  enum role: [:admin, :manager, :team_leader, :client, :staff]

  after_initialize :set_default_role, :if => :new_record?

  private
  def set_default_role
    self.role ||= :staff
  end


end
