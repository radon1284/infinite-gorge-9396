class AddEmploymentIdToStaffs < ActiveRecord::Migration
  def change
    add_reference :staffs, :employment, index: true, foreign_key: true
  end
end
