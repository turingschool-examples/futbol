require_relative './team'
require_relative './game_teams_collection'

class TeamsCollection
  attr_reader :teams
  def initialize(file_path, parent)
    @parent = parent
    @teams = []
    create_teams(file_path)
  end

  def create_teams(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @teams << Team.new(row, self)
    end
  end

  def find_by_id(id)
    teams.find do |team|
      if team.team_id == id
        return team.teamname
      end
    end
  end

  def count_of_teams
    @teams.length
  end

  def team_info(team_id)
    the_team = @teams.find do |team|
      team.team_id == team_id
    end
    the_team.team_info
  end
end
