class AddStaffIdToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :staff_id, :integer
  end
end
