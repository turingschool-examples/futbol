require 'pry'
class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(filepaths_hash)
    games = GameFactory.create_games(filepaths_hash[:games])
    teams = TeamFactory.create_teams(filepaths_hash[:teams])
    game_teams = GameTeamFactory.create_game_teams(filepaths_hash[:game_teams])

    return StatTracker.new(games, teams, game_teams)
  end

  # Game Statistics

  def highest_total_score
    highest_game = @games.max_by {|game| game.away_goals + game.home_goals}
    return (highest_game.away_goals + highest_game.home_goals)
  end

  def lowest_total_score
    lowest_game = @games.min_by {|game| game.away_goals + game.home_goals}
    return (lowest_game.away_goals + lowest_game.home_goals)
  end

  def percentage_home_wins
    # (wins / total_games) * 100.round(2)
    home_wins = @game_teams.find_all { |game| (game.hoa == "home") && (game.result == "WIN")}.count.to_f
    total_games = @game_teams.count.to_f
    return (home_wins / total_games) * 100.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @game_teams.find_all { |game| (game.hoa == "away") && (game.result == "WIN")}.count.to_f
    total_games = @game_teams.count.to_f
    return (visitor_wins / total_games) * 100.round(2)
  end

  def percentage_ties
    games_tied = @game_teams.find_all { |game| game.result == "TIE"}.count.to_f
    total_games = @game_teams.count.to_f
    return (games_tied / total_games) * 100.round(2)    
  end

  def count_of_games_by_season
    
  end

  def average_goals_per_game
    
  end

  def average_goals_by_season
    
  end

   # League Statistics
   
  def count_of_teams
    
  end

  def best_offense
    
  end

  def worst_offense
    
  end

  def highest_scoring_visitor
    
  end

  def highest_scoring_home_team
    
  end

  def lowest_scoring_visitor
    
  end

  def lowest_scoring_home_team
    
  end

  # Season Stats
  
  def winningest_coach
    
  end

  def worst_coach
    
  end

  def most_accurate_team
    
  end

  def least_accurate_team
    
  end

  def most_tackles
    
  end

  def fewest_tackles
    
  end

end