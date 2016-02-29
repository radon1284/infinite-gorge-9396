class AddCreditsToEmployments < ActiveRecord::Migration
  def change
    add_column :employments, :credits, :float
  end
end
