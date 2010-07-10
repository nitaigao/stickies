class AddColumnOrder < Sequel::Migration

  def up
    DB.alter_table :columns do
      add_column :order, :integer, :default => 0
    end
  end

  def down
    DB.alter_table :columns do
      drop_column :order
    end
  end
  
end
