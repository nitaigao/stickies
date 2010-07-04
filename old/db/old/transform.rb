require 'rubygems'
require 'fastercsv'
require 'sequel'

DB = Sequel.connect("mysql://localhost/storyhub_dev?user=root") 

class Story
  def initialize(row)
    @description = row[1]
  end

  def save(column_id, index)
    DB[:stories].insert(:column_id => column_id, :title => @description, :index => index)
  end
end

class Column
  def initialize(row)
    @title = row[1]
    @stories = []
  end
  
  def add_story(story)
    @stories << story
  end
  
  def save(wall_id)
    column_id = DB[:columns].insert(:wall_id => wall_id, :title => @title)
    index = 0
    @stories.each do |story|
      index = index + 1
      story.save(column_id, index)
    end
  end
end

class Wall

  def initialize(row)
    @name = row[1]
    @columns = []
  end

  def add_column(column)
    @columns << column
  end

  def save(user_id)
    wall_id = DB[:walls].insert(:name => @name)      
    DB[:users_walls].insert(:user_id => user_id, :wall_id => wall_id)
    @columns.each do |column|
      column.save(wall_id)
    end
  end

  def self.load_walls
    walls = []
    FasterCSV.foreach("projects.csv") do |wall_row|
      wall =  Wall.new(wall_row)
      columns = FasterCSV.read("columns.csv").select { |column_row| column_row[2] == wall_row[0] }
      columns.each do |column_row|
        column = Column.new(column_row)
        wall.add_column(column)
        stories = FasterCSV.read("stories.csv").select { |story_row| story_row[2] == column_row[0] }
        stories.each do |story_row|
          column.add_story(Story.new(story_row))
        end
      end
      walls << wall
    end
    walls
  end
end

user_id = DB[:users].insert(:open_id => 'http://nkostelnik.myopenid.com/', :nickname => 'Nick')
Wall.load_walls.each do |wall|
  wall.save(user_id)
end

