class User < ActiveRecord::Base
  # rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :meta, polymorphic: true

  # ROLES = %i[admin manager team_leader client staff]

  # belongs_to :role

  # before_create :set_default_role


  enum role: [:admin, :manager, :team_leader, :client, :staff]

  after_initialize :set_default_role, :if => :new_record?

  private
  def set_default_role
    self.role ||= :staff
  end


  # private
  # def set_default_role
  # 	add_role(:staff)
  # end


end
