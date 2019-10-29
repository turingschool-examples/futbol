require_relative './game_team'
require_relative './team'
require 'CSV'

class Fan
  attr_reader :game_teams, :teams
  def initialize(csv_file_path_1, csv_file_path_2)
    @game_teams = create_game_teams(csv_file_path_1)
    @teams = create_teams(csv_file_path_2)
  end

  def create_game_teams(csv_file_path_1)
    GameTeamCollection.new("./test/test_game_team_data.csv")
  end

  def create_teams(csv_file_path_2)
    TeamCollection.new("./data/teams.csv")
  end

  def best_fans_team_id
    diff = @game_teams.home_win_percentage.merge(@game_teams.away_win_percentage) do |key, home_win_percent, away_win_percent|
      (home_win_percent - away_win_percent)
    end
      best = diff.max_by do |team|
        team.last
      end
      best.first
  end

  def best_fans
      best_fans_team = @teams.teams.find do |team|
        team.team_id == best_fans_team_id
      end
      best_fans_team.teamName
  end

  def worst_fans_team_id
      diff = @game_teams.away_wins.merge(@game_teams.home_wins) do |key, away_wins, home_wins|
        away_wins - home_wins
      end
      positives = diff.find_all { |gt| gt.last > 0 }
      positives.map { |array| array.first }
  end

  def worst_fans
    worst_fans_teams = @teams.teams.find_all do |team|
      worst_fans_team_id.include?(team.team_id)
    end
    worst_fans_teams.map do |team|
      team.teamName
    end
  end
end