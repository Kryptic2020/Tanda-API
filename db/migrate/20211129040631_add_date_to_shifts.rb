class AddDateToShifts < ActiveRecord::Migration[6.1]
  def change
    add_column :shifts, :date, :datetime
  end
end
