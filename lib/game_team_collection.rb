require_relative 'loadable'
require_relative 'game_teams'
require_relative 'game'
require_relative 'team'

class GameTeamCollection
  include Loadable

  attr_reader :game_teams_array

  def initialize(file_path)
    @game_teams_array = create_game_teams_array(file_path)
  end

  def create_game_teams_array(file_path)
    load_from_csv(file_path, GameTeams)
  end

  def find_number_of_games_played_in_a_season(team_id)
    games_played_that_season = Hash.new(0)
    @game_teams_array.find_all do |team|
      if team.team_id == team_id.to_s
        games_played_that_season[team.game_id.slice(0...4)] += 1.to_f
      end
    end
    games_played_that_season
  end

  def best_season(team_id)
    games_won_that_season = Hash.new(0)
    @game_teams_array.find_all do |team|
      if team.team_id == team_id.to_s
        if team.result == "WIN"
          games_won_that_season[team.game_id.slice(0...4)] += 1.to_f
        end
      end
    end
    games_won_that_season.merge!(find_number_of_games_played_in_a_season(team_id)) { |k, o, n| o / n }
    ((games_won_that_season.key(games_won_that_season.values.max) * 2).to_i + 1).to_s
  end

  def worst_season(team_id)
    games_lost_that_season = Hash.new(0)
    @game_teams_array.find_all do |team|
      if team.team_id == team_id.to_s
        if team.result == "LOSS"
          games_lost_that_season[team.game_id.slice(0...4)] += 1.to_f
        end
      end
    end
    games_lost_that_season.merge!(find_number_of_games_played_in_a_season(team_id)) { |k, o, n| o / n }
    ((games_lost_that_season.key(games_lost_that_season.values.min) * 2).to_i + 1).to_s
  end

  def average_win_percentage(team_id)
    games_won_that_season = Hash.new(0)
    @game_teams_array.find_all do |team|
      if team.team_id == team_id.to_s
        if team.result == "WIN"
          games_won_that_season[team.game_id.slice(0...4)] += 1.to_f
        end
      end
    end
    (games_won_that_season.values.sum / find_number_of_games_played_in_a_season(team_id).values.sum * 100).round(2)
  end

  def goals_scored(team_id)
    all_goals_scored = []
    @game_teams_array.map do |team|
      if team.team_id == team_id.to_s
        all_goals_scored << team.goals.to_i
      end
    end
    all_goals_scored
  end

  def most_goals_scored(team_id)
    goals_scored(team_id).max
  end

  def fewest_goals_scored(team_id)
    goals_scored(team_id).min
  end
end
