require_relative 'team'
require_relative 'data_loadable'

class TeamStats
  include DataLoadable
  attr_reader :teams

  def initialize(file_path, object)
    @teams = csv_data(file_path, object)
  end

  def find_name(id)
    team = @teams.find { |team| team.team_id == id } 
    team.teamname
  end

  def find_name(id)
    team = @teams.find { |team| team.team_id == id }
    team.teamname
  end

  def find_name(id)
     team = @teams.find { |team| team.team_id == id }
     team.teamname
  end

  def count_of_teams
    @teams.count
  end
end
