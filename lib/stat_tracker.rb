require 'csv'
require 'pry'
require 'data_warehouse'
require 'season_stats'

class StatTracker

  attr_reader :data_warehouse


  def initialize(games, teams, game_teams)
    @data_warehouse = DataWarehouse.new(games, teams, game_teams)
  end

  def self.from_csv(locations)
    StatTracker.new(
    CSV.read(locations[:games], headers: true, header_converters: :symbol),
    CSV.read(locations[:teams], headers: true, header_converters: :symbol),
    CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    )
  end

  def winningest_coach(target_season)

    data = @data_warehouse.data_by_season(target_season)
    season_stats = SeasonStats.new(data)
    season_stats.winningest_coach

  end

  def worst_coach(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game|
                    game_ids.include?(game[:game_id])
                  end

    coaches_and_results= game_teams.map do |game|
                            [game[:result], game[:head_coach]]
                          end

    wins = Hash.new(0)
    all_games = Hash.new(0)

    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      all_games[coach] += 1
      wins[coach] += 0
    end

    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / all_games[coach]
    end

    win_percentage.max_by{|coach, percentage| -percentage}.first
  end

  def most_accurate_team(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game|
                    game_ids.include?(game[:game_id])
                  end

    goals = Hash.new(0)
    shots = Hash.new(0)
    game_teams.each do |game|
      goals[game[:team_id]] += game[:goals].to_f
      shots[game[:team_id]] += game[:shots].to_f
    end

    team_id_accuracy = Hash.new
    goals.each do |team, goals|
      team_id_accuracy[team] = goals / shots[team]
    end

    team_id_highest_accuracy = team_id_accuracy.max_by{|team, acc| acc}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[team_id_highest_accuracy]

  end

  def least_accurate_team(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game|
                    game_ids.include?(game[:game_id])
                  end

    goals = Hash.new(0)
    shots = Hash.new(0)
    game_teams.each do |game|
      goals[game[:team_id]] += game[:goals].to_f
      shots[game[:team_id]] += game[:shots].to_f
    end

    team_id_accuracy = Hash.new
    goals.each do |team, goals|
      team_id_accuracy[team] = goals / shots[team]
    end

    team_id_lowest_accuracy = team_id_accuracy.max_by{|team, acc| -acc}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[team_id_lowest_accuracy]
  end

  def most_tackles(target_season)
    games = @games.to_a.select do |game|
              game[1] == target_season
            end
    game_ids = games.map do |game|
                game[0]
               end
    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                  end
    id_tackles = Hash.new(0)
    game_teams.each do |game|
      id_tackles[game[:team_id]] += game[:tackles].to_i
    end

    most_tackles = id_tackles.max_by{|id, tackles| tackles}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[most_tackles]
  end

  def fewest_tackles(target_season)
    games = @games.to_a.select do |game|
              game[1] == target_season
            end
    game_ids = games.map do |game|
                game[0]
               end
    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                  end
    id_tackles = Hash.new(0)
    game_teams.each do |game|
      id_tackles[game[:team_id]] += game[:tackles].to_i
    end

    fewest_tackles = id_tackles.max_by{|id, tackles| -tackles}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[fewest_tackles]
  end

  def count_of_teams
    @data_warehouse.teams.count
  end

  def best_offense
    data = @data_warehouse
    @league_stats = LeagueStats.new(data)
    @league_stats.best_offense
  end

  def worst_offense
    data = @data_warehouse
    @league_stats = LeagueStats.new(data)
    @league_stats.worst_offense
  end

  def highest_scoring_visitor
    data = @data_warehouse
    @league_stats = LeagueStats.new(data)
    @league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    data = @data_warehouse
    @league_stats = LeagueStats.new(data)
    @league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    data = @data_warehouse
    @league_stats = LeagueStats.new(data)
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    data = @data_warehouse
    @league_stats = LeagueStats.new(data)
    @league_stats.lowest_scoring_home_team
  end

end
