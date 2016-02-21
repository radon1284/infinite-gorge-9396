class User < ActiveRecord::Base
  before_save :skip_email_confirmtion
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :task_logs
         
  belongs_to :meta, polymorphic: true

  enum role: [:admin, :manager, :team_leader, :client, :staff]

  after_initialize :set_default_role, :if => :new_record?

    has_many :team_leader, class_name: "User", foreign_key: "manager_id"
    belongs_to :manager, class_name: "User"

    has_many :staff, class_name: "User", foreign_key: "team_leader_id"
    belongs_to :team_leader, class_name: "User"

    has_many :client, class_name: "User", foreign_key: "team_leader_id"
    belongs_to :team_leader, class_name: "User"


  private
  def set_default_role
    self.role ||= :staff
  end

  def skip_email_confirmtion
   self.skip_confirmation!
  end


end
