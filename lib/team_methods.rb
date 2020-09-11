

require 'CSV'

class TeamMethods
  attr_reader :file_loc,:table

  def initialize(file_loc)
    @file_loc = file_loc
    @table = create_table
    @team_id = @table['team_id']
    @franchiseId = @table['franchiseId']
    @teamName = @table['teamName']
    @abbreviation = @table['abbreviation']
    @Stadium = @table['Stadium']
    @link = @table['link']
  end

  def create_table
    CSV.parse(File.read(@file_loc), headers: true)
  end

  def team_info
    require 'pry'; binding.pry
  end
end
