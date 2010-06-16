class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :description
      t.integer :column_id
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
