class CreateDatabase < Sequel::Migration

  def up
    
    create_table(:users) do
      primary_key :id
      String :open_id
      String :nickname
    end
    
    create_table(:walls) do
      primary_key :id
      String :title
    end
    
    create_table(:users_walls) do
      primary_key :id
      Integer :user_id
      Integer :wall_id
    end

  end

  def down
    drop_table(:users)
  end
  
end
