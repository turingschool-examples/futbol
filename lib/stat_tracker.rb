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
     
  def count_of_teams
    @teams.length
  end

  def count_of_games_by_season
    season_game = []
    @games.each do |game|
      season_game << game[:season]
    end
    season_game.tally
  end

  def most_accurate_team(season)
    team_accuracy = {}

    season_games = @game_teams.select {|game_team| game_team[:game_id][0..3] == season[0..3]}
    season_team_ids = season_games.group_by {|season_game| season_game[:team_id]}.keys
  
    season_team_ids.each do |season_team_id|
      team_season_games = season_games.select {|season_game| season_game[:team_id] == season_team_id}
      team_season_goals = team_season_games.sum {|team_season_game| team_season_game[:goals]}
      team_season_shots = team_season_games.sum {|team_season_game| team_season_game[:shots]}
      team_accuracy[season_team_id] = team_season_goals / team_season_shots.to_f 
    end   
    best_team = team_accuracy.max_by {|team| team[1]}[0]
    @teams.find {|team| team[:team_id] == best_team}[:teamname]
  end

  def least_accurate_team(season)
    team_accuracy = {}

    season_games = @game_teams.select {|game_team| game_team[:game_id][0..3] == season[0..3]}
    season_team_ids = season_games.group_by {|season_game| season_game[:team_id]}.keys
    
    season_team_ids.each do |season_team_id|
      team_season_games = season_games.select {|season_game| season_game[:team_id] == season_team_id}
      team_season_goals = team_season_games.sum {|team_season_game| team_season_game[:goals]}
      team_season_shots = team_season_games.sum {|team_season_game| team_season_game[:shots]}
      team_accuracy[season_team_id] = team_season_goals / team_season_shots.to_f 
    end
    worst_team = team_accuracy.min_by {|team| team[1]}[0]
    @teams.find {|team| team[:team_id] == worst_team}[:teamname]
  end
  
  def most_goals_scored(team_id)
    team_games = @game_teams.select {|game_team| game_team[:team_id] == team_id}
    team_games.max_by {|team_game| team_game[:goals]}[:goals]
  end

  def fewest_goals_scored(team_id)
    team_games = @game_teams.select {|game_team| game_team[:team_id] == team_id}
    team_games.min_by {|team_game| team_game[:goals]}[:goals]
  end
  
  def favorite_opponent(team_id)
    team_games = @games.select {|game| game[:away_team_id] == team_id || 
                                       game[:home_team_id] == team_id}
    team_game_teams = team_games.map do |team_game|
        @game_teams.find {|game_team| game_team[:game_id] == team_game[:game_id] && game_team[:team_id] != team_id}
    end
    team_game_opponents = team_game_teams.group_by {|team_game_team| team_game_team[:team_id]}
    team_game_win_percentages = team_game_opponents.transform_values do |team_game_opponent|
      opponent_losses = team_game_opponent.count {|game_team| game_team[:result] == "LOSS"}
      opponent_losses / team_game_opponent.count.to_f
    end
    favorite_team_id = team_game_win_percentages.max_by do |team_game_win_percentage| 
      team_game_win_percentage[1]
    end.first
    @teams.find {|team| team[:team_id] == favorite_team_id}[:teamname]
  end

  def rival(team_id)
    team_games = @games.select {|game| game[:away_team_id] == team_id || 
                                       game[:home_team_id] == team_id}
    team_game_teams = team_games.map do |team_game|
        @game_teams.find {|game_team| game_team[:game_id] == team_game[:game_id] && game_team[:team_id] != team_id}
    end
    team_game_opponents = team_game_teams.group_by {|team_game_team| team_game_team[:team_id]}
    team_game_win_percentages = team_game_opponents.transform_values do |team_game_opponent|
      opponent_wins = team_game_opponent.count {|game_team| game_team[:result] == "WIN"}
      opponent_wins / team_game_opponent.count.to_f
    end
    rival_team_id = team_game_win_percentages.max_by do |team_game_win_percentage| 
      team_game_win_percentage[1]
    end.first
    @teams.find {|team| team[:team_id] == rival_team_id}[:teamname]
  end  
 
end