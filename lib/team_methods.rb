require 'CSV'
class TeamMethods
  attr_reader :file_loc, :table

  def initialize(file_loc)
    @file_loc = file_loc
    @table = create_table
  end

  def create_table
    CSV.parse(File.read(@file_loc), headers: true)
  end

  def count_of_teams
    @table['teamName'].count
  end
end
