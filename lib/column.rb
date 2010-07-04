class Column < Sequel::Model
  many_to_one :wall
  one_to_many :stories
  
  def url_title
    URI.escape(self.title)
  end
end