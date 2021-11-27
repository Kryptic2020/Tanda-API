class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.datetime :start
      t.datetime :finish
      t.boolean :active

      t.timestamps
    end
  end
end
