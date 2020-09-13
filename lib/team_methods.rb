

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
require 'CSV'
class TeamMethods
  attr_reader :teams_table, :teams

  def initialize(teams)
    @teams = teams
    @teams_table = create_table(@teams)
  end

  def create_table(file)
    CSV.parse(File.read(file), headers: true)
  end

  def count_of_teams
    @teams_table['teamName'].count
  end

  def find_by_id(team_id)
    team = @teams_table.find do |team|
      team['team_id'] == team_id
    end
    team['teamName']
  end
end
