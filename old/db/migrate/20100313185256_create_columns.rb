class CreateColumns < ActiveRecord::Migration
  def self.up
    create_table :columns do |t|
      t.string :title
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :columns
  end
end
