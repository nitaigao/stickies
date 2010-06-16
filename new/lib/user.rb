class User < Sequel::Model
  many_to_many :walls
end