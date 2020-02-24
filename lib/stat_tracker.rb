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
    #most losses, with biggest point difference,
  end

  def best_fans
    #biggest diff between home and win percentages.
    #first, total games played by each team
    games_played = Hash.new(0)
    @gtc.game_teams.each do |game_team|
      if games_played[game_team.team_id] == 0
        games_played[game_team.team_id] = [game_team]
      elsif games_played[game_team.team_id] != 0
        games_played[game_team.team_id] << game_team
      end
    end

    #next, of those games, how many won at home and away
    

    require "pry"; binding.pry
    # games_played_at_home =@gtc.game_teams.find_all do |game_team|
    #   game_team.result == "WIN" && game_team.hoa == "home"
    # end
    # games_won_at_home =@gtc.game_teams.find_all do |game_team|
    #   game_team.result == "WIN" && game_team.hoa == "home"
    # end
    # team_most_win_games = games_won_at_home.max_by do |game|
    #   games_won_at_home.count(game.team_id)
    # end
    # team = @team_collection.teams.find do |team|
    #   team.team_id == team_most_win_games.team_id
    # end

  end

  def lowest_scoring_visitor
    #team with lowest totals when playing as visitor
  end

end
