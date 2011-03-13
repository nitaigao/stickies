class CreateDatabase < Sequel::Migration

  def up
    create_table(:users) do
      primary_key :id
      String :open_id
      String :nickname
    end
    
    create_table(:walls) do
      primary_key :id
      String :name
      String :wall_type
    end
    
    create_table(:users_walls) do
      primary_key :id
      Integer :user_id
      Integer :wall_id
    end
    
    create_table(:columns) do
      primary_key :id
      Integer :wall_id
      String :title
    end
    
    create_table(:stories) do
      primary_key :id
      Integer :column_id
      String :title
      String :index
    end
  end

  def down
    drop_table(:users)
    drop_table(:walls)
    drop_table(:users_walls)
    drop_table(:columns)
    drop_table(:stories)
  end
  
end
