require 'csv'
require './lib/team'
require './lib/game'
require './lib/season'
require './lib/game_stats'
require './lib/league_stats'

class StatTracker
  include GameStats
  include LeagueStats

  attr_reader :games,
              :teams,
              :seasons

  def initialize(games, teams, game_teams)
    @teams = Team.generate_teams(teams) #array of team objects
    @games = Game.generate_games(games, game_teams, @teams)#an array of all game stats with hashes for home teams and away teams
    @seasons = Season.generate_seasons(@games) #a hash of season_id and keys and season objects as values
  end

  def self.from_csv(locations)
    games = CSV.table(locations[:games], converters: :all)
    teams = CSV.table(locations[:teams], converters: :all)
    game_teams = CSV.table(locations[:game_teams], converters: :all)
    StatTracker.new(games, teams, game_teams)
  end

  def total_scores_per_game
    games[:away_goals].sum + games[:home_goals].sum
  end

  def lowest_total_score
    @games.map {|game| game[:away_goals] + game[:home_goals]}.min
  end

  def highest_total_score
    @games.map{|game| game[:away_goals] + game[:home_goals]}.max
  end

  def percentage_ties
    total_tie_games = @games.count{ |game| game[:away_goals] == game[:home_goals] }
    (total_tie_games.to_f / @games.length).round(2)

  def percentage_visitor_wins
    total_away_wins = @game_teams.count do |game_team|
      game_team[:hoa] == "away" && game_team[:result] == "WIN"
    end
    (total_away_wins/@games.length.to_f).round(2)
  end

  def count_of_games_by_season
   games_by_season = Hash.new(0)

   @games.each do |game|
     games_by_season[game[:season]] += 1
    end
   games_by_season
  end

  def count_of_teams
    @teams[:team_id].uniq.count
  end

  def average_goals_by_season
    average_goals_per_season = Hash.new(0)
    seasons = @games[:season].uniq
    seasons.each do |season|
      total_goals_in_season = 0
      total_games_in_season = 0
      @games.each do |game|
        if game[:season] == season
          total_goals_in_season += game[:away_goals] + game[:home_goals]
          total_games_in_season += 1
        end
      end
      average_goals_per_season[season] = total_goals_in_season.to_f / total_games_in_season
    end
    average_goals_per_season
  end

  def teams_and_goals #=> League Stats Helper Method
    teams_and_goals_hash = {}
    @teams.each do |team|
      teams_and_goals_hash[team[:team_id]] = {
        team_name: team[:teamname],
        total_goals: 0,
        total_games: 0,
        total_home_goals: 0,
        total_away_goals: 0,
        total_home_games: 0,
        total_away_games: 0
      }
    end
    @game_teams.each do |game_team|
      teams_and_goals_hash[game_team[:team_id]][:total_goals] += game_team[:goals]
      teams_and_goals_hash[game_team[:team_id]][:total_games] += 1
      if game_team[:hoa] == 'home'
        teams_and_goals_hash[game_team[:team_id]][:total_home_goals] += game_team[:goals]
        teams_and_goals_hash[game_team[:team_id]][:total_home_games] += 1
      else
        teams_and_goals_hash[game_team[:team_id]][:total_away_goals] += game_team[:goals]
        teams_and_goals_hash[game_team[:team_id]][:total_away_games] += 1
      end
    end
    teams_and_goals_hash
  end

  def worst_offense
    result = teams_and_goals.min_by do |team, stats|
      stats[:total_goals].to_f / stats[:total_games]
    end
    result[1][:team_name]
  end

  def best_offense
    result = teams_and_goals.max_by do |team, stats|
      stats[:total_goals].to_f / stats[:total_games]
    end
    result[1][:team_name]
  end

  def highest_scoring_home_team
    high_scoring = teams_and_goals.max_by{|team, stats| stats[:total_home_goals].to_f / stats[:total_home_games]}
    high_scoring[1][:team_name]
  end

  def lowest_scoring_home_team
    low_scoring = teams_and_goals.min_by{|teams, stats| stats[:total_home_goals].to_f / stats[:total_home_games]}
    low_scoring[1][:team_name]
  end

  def highest_scoring_visitor
    high_scoring = teams_and_goals.max_by{|teams, stats| stats[:total_away_goals].to_f / stats[:total_away_games]}
    high_scoring[1][:team_name]
  end

  def lowest_scoring_visitor
    low_scoring = teams_and_goals.min_by{|teams, stats| stats[:total_away_goals].to_f / stats[:total_away_games]}
    low_scoring[1][:team_name]
  end

  def tackles_by_team(season) #helper method, returns hash with keys team_id and values number of tackles
    season_game_ids = []
    @games.each do |game|
      season_game_ids << game[:game_id] if season.to_i == game[:season]
    end
    team_tackle_data = Hash.new(0)
    @game_teams.each do |game_team|
      season_game_ids.each do |game_id|
        if game_team[:game_id] == game_id
          team_tackle_data[game_team[:team_id]] += game_team[:tackles]
        end
      end
    end
    team_tackle_data
  end

  def fewest_tackles(season)
    result_team_id = tackles_by_team(season).min_by do |team_id, tackles|
      tackles
    end.first
    result_team_name = ""
    @teams.each{ |team| result_team_name = team[:teamname] if team[:team_id] == result_team_id }
    result_team_name
  end

  def most_tackles(season)
    result_team_id = tackles_by_team(season).max_by do |team_id, tackles|
      tackles
    end.first
    result_team_name = ""
    @teams.each{ |team| result_team_name = team[:teamname] if team[:team_id] == result_team_id }
    result_team_name
  end

  def team_info(team)
    team_info = Hash.new()
    @teams.each do |individual_team|
      if individual_team[:teamname] == team
        team_info = {"team_id" => individual_team[:team_id].to_s, "franchise_id" => individual_team[:franchiseid].to_s, "team_name" => individual_team[:teamname], "abbreviation" => individual_team[:abbreviation], "link" => individual_team[:link]}
      end
    end
    team_info
  end

end
