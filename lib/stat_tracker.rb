require 'csv'
require './lib/game_teams_collection'
require './lib/game_collection'
require './lib/team_collection'

class StatTracker

  def self.from_csv(locations)
    raw_data = {}
    raw_data[:game_data] = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    raw_data[:team_data] = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    raw_data[:game_teams_data] = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    StatTracker.new(raw_data)
  end

  attr_reader :game_collection, :team_collection, :gtc
  def initialize(raw_data)
    @game_data = raw_data[:game_data]
    @team_data = raw_data[:team_data]
    @game_teams_data = raw_data[:game_teams_data]
    @gtc = nil
    @game_collection = nil
    @team_collection = nil
    construct_collections
  end

  def construct_collections
    @gtc = GameTeamsCollection.new(@game_teams_data)
    @game_collection = GameCollection.new(@game_data)
    @team_collection = TeamCollection.new(@team_data)
  end

  def highest_total_score
    game_collection.games.map do |game|
      game.home_goals + game.away_goals
    end.max
  end

  def biggest_blowout
    game_collection.games.map do |game|
      Math.sqrt((game.home_goals - game.away_goals)**2).to_i
    end.max
  end

  def percentage_ties
    ties = game_collection.games.find_all do |game|
      game.home_goals == game.away_goals
    end.length
    (ties / game_collection.games.length.to_f).round(2)
  end

  def count_of_games_by_season
    games_in_season = Hash.new(0)
    game_collection.games.each do |game|
        games_in_season[game.season] += 1
    end
    games_in_season
  end

  def count_of_teams
    @team_collection.teams.length
  end

  def worst_defense
    # Name of the team with the highest average number of goals
    # allowed per game across all seasons.
    #find all games per team
    teams_per_game = @gtc.game_teams.reduce(Hash.new(nil)) do |games_played, game_team|
      if games_played[game_team.game_id] == nil
        games_played[game_team.game_id] = [game_team]
      elsif games_played[game_team.game_id] != nil
        games_played[game_team.game_id] << game_team
      end
      games_played
    end
    # find other teams stats from that game
    require "pry"; binding.pry
    

    #points-allowed-per-game by team
  end

  def best_fans
    #biggest diff between home/away win percentages.
    home_games_played = Hash.new(0)
    @game_collection.games.each do |game|
      if home_games_played[game.home_team_id] == 0
        home_games_played[game.home_team_id] = [game]
      elsif home_games_played[game.home_team_id] != 0
        home_games_played[game.home_team_id] << game
      end
    end

    home_games_won = Hash.new(0)
    home_games_played.each do |team_id, games|
      games_won = games.find_all { |game| game.home_goals > game.away_goals}
      home_games_won[team_id] = games_won
    end

    home_win_percentages = Hash.new(0)
    home_games_played.each_key do |team_id|
      percentage = 100 * (home_games_won[team_id].count.to_f / home_games_played[team_id].count.to_f).round(2)
      home_win_percentages[team_id] = percentage
    end

    away_games_played = Hash.new(0)
    @game_collection.games.each do |game|
      if away_games_played[game.away_team_id] == 0
        away_games_played[game.away_team_id] = [game]
      elsif away_games_played[game.away_team_id] != 0
        away_games_played[game.away_team_id] << game
      end
    end

    away_games_won = Hash.new(0)
    away_games_played.each do |team_id, games|
      games_won = games.find_all { |game| game.home_goals < game.away_goals}
      away_games_won[team_id] = games_won
    end

    away_win_percentages = Hash.new(0)
    away_games_played.each_key do |team_id|
      percentage = 100 * (away_games_won[team_id].count.to_f / away_games_played[team_id].count.to_f).round(2)
      away_win_percentages[team_id] = percentage
    end

    percentage_differences = Hash.new(0)
    home_win_percentages.each do |team_id, home_percentage|
      away_percentage = away_win_percentages[team_id]
      percentage_differences[team_id] = (home_percentage - away_percentage).abs
    end

    team_with_largest_difference = percentage_differences.max_by { |team_id, percentage_diff| percentage_diff}

    team = @team_collection.teams.find do |team|
      team.team_id == team_with_largest_difference[0]
    end
    team.teamname
  end

  def lowest_scoring_visitor
    #team with lowest totals when playing as visitor
  end

end
