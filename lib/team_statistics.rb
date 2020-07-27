require_relative "game_data"
require_relative "team_data"
require_relative "game_team_data"
require "csv"

class TeamStatistics

  def initialize
    @team_info_by_id = Hash.new
  end

  def all_teams
    TeamData.create_objects
  end

  def all_games
    GameData.create_objects
  end

  def all_game_teams
    GameTeamData.create_objects
  end

  def team_info(passed_id)
    all_teams.each do |team|
      if passed_id == team.team_id.to_s # Remove .to_s when spec harness info updates
        @team_info_by_id[:team_id] = team.team_id
        @team_info_by_id[:franchise_id] = team.franchise_id
        @team_info_by_id[:team_name] = team.team_name
        @team_info_by_id[:abbreviation] = team.abbreviation
        @team_info_by_id[:link] = team.link
      end
    end
    @team_info_by_id
  end

end
