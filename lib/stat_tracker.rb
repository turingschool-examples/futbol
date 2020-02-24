require 'csv'
# require './lib/modules/calculable'
require_relative 'game'
require_relative 'game_team'
require_relative 'team'

class StatTracker
  # include Calculable

  def initialize()
  end

  def self.from_csv(locations)
    StatTracker.create_items(locations[:games], Game)
    StatTracker.create_items(locations[:game_teams], GameTeam)
    StatTracker.create_items(locations[:teams], Team)
    StatTracker.new()
  end

  def self.create_items(file, item_class)
    csv_options = {
                    headers: true,
                    header_converters: :symbol,
                    converters: :all
                  }
      CSV.foreach(file, csv_options) { |row| item_class.add(item_class.new(row.to_hash)) }
  end

  def sort(class_object, function = "add")
    total_scores = []
    class_object.all.each_value do |value|
      if function == "subtract"
        total_scores << (value.home_goals - value.away_goals).abs
      else
        total_scores << value.home_goals + value.away_goals
      end
    end
    total_scores.uniq.sort
  end

  def highest_total_score
    sort(Game).max
  end

  def lowest_total_score
    sort(Game).min
  end

  def biggest_blowout
    sort(Game, "subtract").max
  end

  def games_outcome_percent(outcome = nil)
    games_count = 0.0
    Game.all.each_value do |value|
      if outcome == "away" && value.home_goals < value.away_goals
        games_count += 1
      elsif outcome == "home" && value.home_goals > value.away_goals
        games_count += 1
      elsif outcome == "draw" && value.home_goals == value.away_goals
        games_count += 1
      end
    end
    (games_count / Game.all.length).round(2)
  end

  def percentage_home_wins
    games_outcome_percent("home")
  end

  def percentage_visitor_wins
    games_outcome_percent("away")
  end

  def percentage_ties
    games_outcome_percent("draw")
  end

  def count_of_games_by_season
    Game.all.values.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game.season.to_s] += 1
      games_by_season
    end
  end

  def average_goals_per_game
    total_goals_per_game = []
    Game.all.each_value do |game|
      total_goals_per_game << game.away_goals + game.home_goals.to_f
    end
    (total_goals_per_game.sum.to_f / Game.all.length).round(2)
  end

  def total_goals_per_season(season)
    total_goals = 0.0
    Game.all.each_value do |game|
      if game.season == season
        total_goals += (game.away_goals + game.home_goals)
      end
    end
    total_goals
  end

  def average_goals_by_season
    Game.all.each_value.reduce(Hash.new(0)) do |goals_by_season, game|
      goals = total_goals_per_season(game.season)
      games = games_in_season(game.season).length

      goals_by_season[game.season.to_s] = (goals / games).round(2)
      goals_by_season
    end
  end

  def games_in_season(season)
    games_in_season = Game.all.values.reduce([]) do |acc, game|
      if game.season == season
        acc << game.game_id
      end
      acc
    end
    games_in_season
  end

  def return_tackles_team(acc, condition = "max")
    if condition == "min"
      tackles = acc.values.min
    else
      tackles = acc.values.max
    end

    team = acc.key(tackles)
    Team.all[team].team_name
  end

  def most_tackles(season)
    games_in_season = games_in_season(season)

    tackles_by_team_by_season = GameTeam.all.values.reduce(Hash.new(0)) do |acc, game|
      game.each_value do |team|
        if games_in_season.include?(team.game_id)
          acc[team.team_id] += team.tackles
        end
      end
      acc
    end

    return_tackles_team(tackles_by_team_by_season)
  end

  def fewest_tackles(season)
    games_in_season = games_in_season(season)

    tackles_by_team_by_season = GameTeam.all.values.reduce(Hash.new(0)) do |acc, game|
      game.each_value do |team|
        if games_in_season.include?(team.game_id)
          acc[team.team_id] += team.tackles
        end
      end
      acc
    end

    return_tackles_team(tackles_by_team_by_season, "min")
  end

#   def total_goals_by_team_in_season(season, team_id)
#     games_in_season = games_in_season(season)
#
#     team_goals = GameTeam.all.values.reduce(0) do |acc, game|
#       game.each_value do |team|
#         if games_in_season.include?(team.game_id) && team.team_id == team_id
#           acc += team.goals
#         end
#       end
#       acc
#     end
#     team_goals
#   end
#
#   def total_shots_by_team_in_season(season, team_id)
#     games_in_season = games_in_season(season)
#
#     team_shots = GameTeam.all.values.reduce(0) do |acc, game|
#       game.each_value do |team|
#         if games_in_season.include?(team.game_id) && team.team_id == team_id
#           acc += team.shots
#         end
#       end
#       acc
#     end
#     team_shots
#   end
#
#   def most_accurate_team(season)
#     games_in_season = games_in_season(season)
#
#     teams_accuracy = GameTeam.all.values.reduce(Hash.new(0)) do |acc, game|
#       game.each_value do |team|
#         shots = total_shots_by_team_in_season(season, team.team_id)
#         goals = total_goals_by_team_in_season(season, team.team_id)
#         acc[team.team_id] = (shots.to_f / goals).round(2)
#       end
#       acc
#     end
#
#     most_accurate = teams_accuracy.values.max
#     team = teams_accuracy.key(most_accurate)
#     Team.all[team].team_name
#   end
#
#   def least_accurate_team(season)
#     games_in_season = games_in_season(season)
#
#     teams_accuracy = GameTeam.all.values.reduce(Hash.new(0)) do |acc, game|
#       game.each_value do |team|
#         shots = total_shots_by_team_in_season(season, team.team_id)
#         goals = total_goals_by_team_in_season(season, team.team_id)
#         acc[team.team_id] = (shots.to_f / goals).round(2)
#       end
#       acc
#     end
#
#     least_accurate = teams_accuracy.values.min
#     team = teams_accuracy.key(least_accurate)
#     Team.all[team].team_name
#   end
end
