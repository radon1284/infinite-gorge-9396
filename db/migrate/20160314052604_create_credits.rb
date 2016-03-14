class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.float :credits
      t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
