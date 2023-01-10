require 'csv'
require_relative '../lib/game_team'

class GameTeamCollection
  attr_reader :game_teams_array

  def initialize(location)
    @game_teams_array = []
	  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
	  @game_teams_array << GameTeam.new(row)
    end
  end

  def add_total_score_and_games(teams_total_scores, teams_total_games)
    @game_teams_array.each do |game_team|
      teams_total_scores[game_team.team_id] += game_team.goals.to_f
      teams_total_games[game_team.team_id] += 1.0
    end
  end
end