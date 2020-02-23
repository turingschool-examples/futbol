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

  def worst_fans
    home_w = hoa_wins_by_team("home")
    away_w = hoa_wins_by_team("away")
    teams = away_w.select do |team, away_wins|
      home_w[team] < away_wins
    end.keys
    teams.map { |team_id| team_name_by_id(team_id) }
  end

  def lowest_scoring_home_team
    home_games = hoa_games_by_team("home")
    home_goals = hoa_goals_by_team("home")
    home_goals_per_game = {}
    home_goals.each do |team_id, total_home_goals|
      next if total_home_goals == 0
      home_goals_per_game[team_id] = total_home_goals / hoa_games_by_team("home")[team_id].to_f
    end
    team_name_by_id(home_goals_per_game.key(home_goals_per_game.values.min))
  end

  def highest_scoring_home_team
    home_games = hoa_games_by_team("home")
    home_goals = hoa_goals_by_team("home")
    home_goals_per_game = {}
    home_goals.each do |team_id, total_home_goals|
      next if total_home_goals == 0
      home_goals_per_game[team_id] = total_home_goals / hoa_games_by_team("home")[team_id].to_f
    end
    team_name_by_id(home_goals_per_game.key(home_goals_per_game.values.max))
  end

  def best_defense
    allowed = all_goals_allowed_by_team
    games = total_games_by_team
    average_goals_allowed = {}
    allowed.each do |team_id, goals_allowed|
      average_goals_allowed[team_id] = goals_allowed / total_games_by_team[team_id].to_f
    end
    team_name_by_id(average_goals_allowed.key(average_goals_allowed.values.min))
  end

  def worst_coach(season)
    ## does not work
    averages = {}
    wins_in_season(season).each do |team_id, wins|
      averages[team_id] = wins / games_by_team_by_season(season)[team_id].to_f
    end
    averages
    head_coaches(season)[averages.key(averages.values.min)]
  end

  ###### move these methods somewhere else

  def total_games_by_season
    games_in_season = Hash.new(0)
    game_collection.games.each do |game|
      games_in_season[game.season] += 1
    end
    games_in_season
  end

  def team_name_by_id(team_id)
    team_collection.teams.find do |team|
      team.team_id == team_id
    end.teamname
  end

  def game_ids_in_season(season)
    game_collection.games.find_all do |game|
      season == game.season
    end.map { |game| game.game_id }
  end

  def games_by_team_by_season(season)
    games_per_team = Hash.new(0)
    game_collection.games.each do |game|
      if season == game.season
        games_per_team[game.home_team_id] += 1
        games_per_team[game.away_team_id] += 1
      end
    end
    games_per_team
  end

  def head_coaches(season)
    skip
    #slow
    gtc.game_teams.reduce({}) do |coaches_in_season, game|
      if game_ids_in_season(season).include?(game.game_id)
        coaches_in_season[game.team_id] = game.head_coach
      end
      coaches_in_season
    end
  end

  # def wins_in_season(season)
  #   require "pry"; binding.pry
  # end

  def total_games_by_team
    games_by_team = Hash.new(0)
    game_collection.games.each do |game|
      games_by_team[game.away_team_id] += 1
      games_by_team[game.home_team_id] += 1
    end
    games_by_team
  end

  def total_wins_by_team
    total_wins = Hash.new(0)
    gtc.game_teams.each do |game|
      if game.result == "WIN"
        total_wins[game.team_id] += 1
      elsif game.result == "LOSS"
        total_wins[game.team_id] =+ 0
      end
    end
    total_wins
  end

  def total_loss_by_team
    total_loss = Hash.new(0)
    gtc.game_teams.each do |game|
      if game.result == "LOSS"
        total_loss[game.team_id] += 1
      elsif game.result == "WIN"
        total_loss[game.team_id] =+ 0
      end
    end
    total_loss
  end

  def total_tie_by_team
    total_loss = Hash.new(0)
    gtc.game_teams.each do |game|
      if game.result == "TIE"
        total_loss[game.team_id] += 1
      elsif game.result == "WIN"
        total_loss[game.team_id] =+ 0
      elsif game.result == "LOSS"
        total_loss[game.team_id] += 0
      end
    end
    total_loss
  end

  def all_goals_scored_by_team
    goals_scored_by_team = Hash.new(0)
    game_collection.games.each do |game|
      goals_scored_by_team[game.away_team_id] += game.away_goals
      goals_scored_by_team[game.home_team_id] += game.home_goals
    end
    goals_scored_by_team
  end

  def all_goals_allowed_by_team
    goals_allowed_by_team = Hash.new(0)
    game_collection.games.each do |game|
      goals_allowed_by_team[game.away_team_id] += game.home_goals
      goals_allowed_by_team[game.home_team_id] += game.away_goals
    end
    goals_allowed_by_team
  end

  def hoa_games_by_team(hoa)
    hoa_games_by_team = Hash.new(0)
    gtc.game_teams.find_all do |game|
      hoa_games_by_team[game.team_id] += 1 if hoa.downcase == game.hoa
    end
    hoa_games_by_team
  end

  def hoa_goals_by_team(hoa)
    hoa_goals_by_team = Hash.new(0)
    gtc.game_teams.find_all do |game|
      if game.hoa == hoa.downcase
        hoa_goals_by_team[game.team_id] += game.goals
      else
        hoa_goals_by_team[game.team_id] += 0
      end
    end
    hoa_goals_by_team
  end

  def hoa_wins_by_team(hoa)
    hoa_wins_by_team = Hash.new(0)
    gtc.game_teams.find_all do |game|
      if hoa.downcase == game.hoa && game.result == "WIN"
        hoa_wins_by_team[game.team_id] += 1
      else
        hoa_wins_by_team[game.team_id] += 0
      end
    end
    hoa_wins_by_team
  end

  def hoa_loss_by_team(hoa)
    hoa_loss_by_team = Hash.new(0)
    gtc.game_teams.find_all do |game|
      if hoa.downcase == game.hoa && game.result == "LOSS"
        hoa_loss_by_team[game.team_id] += 1
      else
        hoa_loss_by_team[game.team_id] += 0
      end
    end
    hoa_loss_by_team
  end

  def hoa_tie_by_team(hoa)
    hoa_tie_by_team = Hash.new(0)
    gtc.game_teams.find_all do |game|
      if hoa.downcase == game.hoa && game.result == "TIE"
        hoa_tie_by_team[game.team_id] += 1
      else
        hoa_tie_by_team[game.team_id] += 0
      end
    end
    hoa_tie_by_team
  end

  ##############
  #These can likely be moved into a module

end
