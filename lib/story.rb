class Story < Sequel::Model
  many_to_one :column
  
  def <=>(other)
    self.index <=> other.index
  end
  
  def title_html
    title.to_s.
      gsub("&", "&amp;").
      gsub("<", "&lt;").
      gsub(">", "&gt;").
      gsub("'", "&#39;").
      gsub('"', "&quot;").
      gsub("\n", "<br>")
  end
  
end