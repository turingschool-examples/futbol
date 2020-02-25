require 'csv'
require_relative 'game'
require_relative 'game_team'
require_relative 'team'

class StatTracker

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

  def highest_total_score
    Game.find_all_scores.max
  end

  def lowest_total_score
    Game.find_all_scores.min
  end

  def biggest_blowout
    Game.find_all_scores("subtract").max
  end

  def percentage_home_wins
    Game.games_outcome_percent("home")
  end

  def percentage_visitor_wins
    Game.games_outcome_percent("away")
  end

  def percentage_ties
    Game.games_outcome_percent("draw")
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
    (total_goals_per_game.sum / Game.all.length).round(2)
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
      games = Game.games_in_a_season(game.season).length

      goals_by_season[game.season.to_s] = (goals / games).round(2)
      goals_by_season
    end
  end

  def return_team_name(acc, condition = "max")
    if condition == "min"
      stat = acc.values.min
    else
      stat = acc.values.max
    end

    team = acc.key(stat)
    Team.all[team].team_name
  end

  def most_tackles(season)
    games = Game.games_in_a_season(season)
    gameteams = GameTeam.season_games(games)

    tackles = Hash.new(0)
    gameteams.each_value do |gameteam|
      gameteam.each_value do |team|
        tackles[team.team_id] += team.tackles
      end
    end
    return_team_name(tackles)
  end

  def fewest_tackles(season)
    games = Game.games_in_a_season(season)
    gameteams = GameTeam.season_games(games)

    tackles = Hash.new(0)
    gameteams.each_value do |gameteam|
      gameteam.each_value do |team|
        tackles[team.team_id] += team.tackles
      end
    end
    return_team_name(tackles, "min")
  end

  def most_accurate_team(season)
    games = Game.games_in_a_season(season)
    gameteams = GameTeam.season_games(games)

    teams = Hash.new
    gameteams.each_value do |gameteam|
      gameteam.each_value do |team|
        teams[team.team_id] = Hash.new(0) if !teams.has_key?(team.team_id)
        teams[team.team_id][:shots] += team.shots
        teams[team.team_id][:goals] += team.goals
      end
    end

    accuracy = teams.transform_values do |team|
      ((team[:goals] / team[:shots].to_f) * 100).round(2)
    end
    return_team_name(accuracy)
  end

  def least_accurate_team(season)
    games = Game.games_in_a_season(season)
    gameteams = GameTeam.season_games(games)

    teams = Hash.new
    gameteams.each_value do |gameteam|
      gameteam.each_value do |team|
        teams[team.team_id] = Hash.new(0) if !teams.has_key?(team.team_id)
        teams[team.team_id][:shots] += team.shots
        teams[team.team_id][:goals] += team.goals
      end
    end

    accuracy = teams.transform_values do |team|
      ((team[:goals] / team[:shots].to_f) * 100).round(2)
    end
    return_team_name(accuracy, "min")
  end

end
