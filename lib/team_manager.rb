require 'csv'

class TeamManager
  attr_reader :teams,
              :tracker
  def initialize(path, tracker)
    @teams = []
    create_underscore_teams(path)
    @tracker = tracker
  end

  def create_underscore_teams(path)
    teams_data = CSV.read(path, headers: true)
    @teams = teams_data.map do |data|
      Team.new(data, self)
    end
  end

  def count_of_teams
    @teams.count
  end

  def team_info(team_id)
    found_team = @teams.find do |team|
      team_id == team.team_id
    end
    found_team_info = {
                      "team_id" => found_team.team_id,
                      "franchise_id" => found_team.franchise_id,
                      "team_name" => found_team.team_name,
                      "abbreviation" => found_team.abbreviation,
                      "link" => found_team.link
                      }
  end

  def get_team_name(team_id)
    @teams.find do |team| # Create find_team_name method? # team_manager.rb
      team.team_id == team_id # Would accept this as argument
    end.team_name
  end

end
