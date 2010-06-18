class Wall < Sequel::Model
  many_to_many :users
  one_to_many :columns
  
  def url_name
    URI.escape(self.name)
  end
end