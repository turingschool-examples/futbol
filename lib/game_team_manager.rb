require_relative 'game_teams'
require 'csv'

class GameTeamManager
  attr_reader :game_teams
  def initialize(locations, stat_tracker)
    @stat_tracker = stat_tracker
    @game_teams = generate_game_teams(locations[:game_teams])
  end

  def generate_game_teams(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << GameTeams.new(row.to_hash)
    end
    array
  end

  def goal_avg_per_team(team_id, home_away)
    goal_array = []
    @game_teams.each do |game|
        if game.team_id == team_id && home_away == game.HoA
          goal_array << game.goals
        elsif game.team_id == team_id && home_away == ''
          goal_array << game.goals
        end
      end
    (goal_array.sum.to_f/goal_array.count).round(2)
  end

  def best_offense
    team_data.max_by{|team| goal_avg_per_team(team.team_id, '')}.team_name
  end

  def team_data
    @stat_tracker.team_manager.teams
  end

end
