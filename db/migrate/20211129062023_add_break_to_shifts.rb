class AddBreakToShifts < ActiveRecord::Migration[6.1]
  def change
    add_column :shifts, :break, :integer, array: true, default: [] 
  end
end
