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
      # require 'pry';binding.pry
    end
    average_goals_per_season
  end
end
