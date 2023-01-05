require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games = create_games(locations[:games])
    @teams = create_teams(locations[:teams])
    @game_teams = create_game_teams(locations[:game_teams])
  end

  def create_games(game_path)
    games = []
    CSV.foreach(game_path, headers: true, header_converters: :symbol ) do |info|
      game = info.to_h
      game[:away_goals] = game[:away_goals].to_i
      game[:home_goals] = game[:home_goals].to_i
      games << game
    end
    games
  end

  def create_teams(team_path)
    teams = []
    CSV.foreach(team_path, headers: true, header_converters: :symbol ) do |info|
      teams << info.to_h
    end
    teams
  end

  def create_game_teams(game_teams_path)
    game_teams = []
    CSV.foreach(game_teams_path, headers: true, header_converters: :symbol ) do |info|
      game_team = info.to_h
      game_team[:goals] = game_team[:goals].to_i
      game_team[:shots] = game_team[:shots].to_i
      game_team[:tackles] = game_team[:tackles].to_i
      game_team[:pim] = game_team[:pim].to_i
      game_team[:powerplayopportunities] = game_team[:powerplayopportunities].to_i
      game_team[:powerplaygoals] = game_team[:powerplaygoals].to_i
      game_team[:faceoffwinpercentage] = game_team[:faceoffwinpercentage].to_f
      game_team[:giveaways] = game_team[:giveaways].to_i
      game_team[:takeaways] = game_team[:takeaways].to_i
      game_teams << game_team
    end
    game_teams
  end

  def self.from_csv(locations)
    new(locations)
  end

  def highest_total_score
    games_total_scores_array.max
  end

  def lowest_total_score
    games_total_scores_array.min
  end

  def games_total_scores_array
    @games.map { |game| game[:away_goals] + game[:home_goals] }
  end

  def percentage_home_wins
    home_win = []
    games_num = []
    @games.each do |game|
        home_win << game if game[:home_goals] > game[:away_goals]
        games_num << game[:game_id]
    end
    (home_win.count / games_num.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_win = []
    games_num = []
    @games.each do |game|
        visitor_win << game if game[:home_goals] < game[:away_goals]
        games_num << game[:game_id]
    end
    (visitor_win.count / games_num.count.to_f).round(2)
  end

  def percentage_ties
    tie_game = []
    games_num = []
    @games.each do |game|
        tie_game << game if game[:home_goals] == game[:away_goals]
        games_num << game[:game_id]
    end
    (tie_game.count / games_num.count.to_f).round(2)
  end

  def average_goals_per_game
    total_goals = 0
    @games.each do |game|
      total_goals += (game[:home_goals] + game[:away_goals])
    end
    (total_goals/@games.count.to_f).round(2)
  end
  
  def average_goals_by_season
    hash = {}
    games_by_season = @games.group_by do |game| 
      game[:season]
    end
    
    games_by_season.each do |season, games|
      hash[season] = 0
      games.each do |game|
        hash[season] += (game[:away_goals] + game[:home_goals])
      end
      hash[season] = (hash[season]/games.size.to_f).round(2)
    end
    hash
  end           
end