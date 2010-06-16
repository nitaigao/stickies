class Wall < Sequel::Model
  many_to_many :users
end