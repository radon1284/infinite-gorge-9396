class AddCompletedAtToCredits < ActiveRecord::Migration
  def change
  	add_column :credits, :completed_at, :datetime
  end
end
