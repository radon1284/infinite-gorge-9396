class AddMultiplierToEmployments < ActiveRecord::Migration
  def change
    add_column :employments, :multiplier, :float
  end
end
