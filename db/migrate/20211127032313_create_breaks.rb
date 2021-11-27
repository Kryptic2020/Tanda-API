class CreateBreaks < ActiveRecord::Migration[6.1]
  def change
    create_table :breaks do |t|
      t.integer :break
      t.references :shift, null: false, foreign_key: true

      t.timestamps
    end
  end
end
