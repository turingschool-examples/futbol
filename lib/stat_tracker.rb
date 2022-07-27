require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams
              :percentage_visitor_wins

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
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

  def average_goals_per_game
    total_goals = @games.sum{ |game| game[:away_goals] + game[:home_goals] }
    (total_goals.to_f / @games.length).round(2)
  end

  def percentage_ties
    total_tie_games = @games.count{ |game| game[:away_goals] == game[:home_goals] }
    (total_tie_games.to_f / @games.length).round(2)
  end

  def percentage_home_wins
    home_wins = @game_teams.count{ |game_team| game_team[:hoa] == "home" && game_team[:result] == "WIN" }
    total_games = @games.length
    (home_wins.to_f / total_games).round(2)
  end

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

  def highest_scoring_home_team
    high_scoring = teams_and_goals.max_by{|teams, stats| stats[:total_home_goals].to_f}
    high_scoring[1][:team_name]
  end

  def lowest_scoring_home_team
    low_scoring = teams_and_goals.min_by{|teams, stats| stats[:total_home_goals].to_f}
    low_scoring[1][:team_name]
  end

  def highest_scoring_visitor
    high_scoring = teams_and_goals.max_by{|teams, stats| stats[:total_away_goals].to_f}
    high_scoring[1][:team_name]
  end

  def lowest_scoring_visitor
    low_scoring = teams_and_goals.min_by{|teams, stats| stats[:total_away_goals].to_f}
    low_scoring[1][:team_name]
  end
end
