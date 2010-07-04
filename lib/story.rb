class Story < Sequel::Model
  many_to_one :column
  
  def <=>(other)
    self.index <=> other.index
  end
end