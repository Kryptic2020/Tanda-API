class DropTableBreaks < ActiveRecord::Migration[6.1]
  def up
    drop_table :breaks
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
