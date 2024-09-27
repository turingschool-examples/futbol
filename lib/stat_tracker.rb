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
  
  def away_games_per_team
    number_of_games = []
    @games.map do |game|
      number_of_games << game[:away_team_id]
    end
    number_of_games.tally
  end
  
  def away_teams_average_scoring_hash
    away_scores_hash = Hash.new(0)
    away_teams_average_scoring_hash = {}
    
    @games.each do |game|
      away_scores_hash[game[:away_team_id]] += (game[:away_goals].to_f)
      
      away_scores_hash.map do |key, value|
        away_scores_hash[key] = value.round(2) 
      end
    end
    
    away_scores_hash.each do |away_id, score_value|
      away_games_per_team.each do |games_id, game_value|
        if games_id == away_id
          away_teams_average_scoring_hash[away_id] = (score_value/game_value).round(2)
        end
      end
    end
    away_teams_average_scoring_hash
  end
    
  def highest_scoring_visitor
    final_id = away_teams_average_scoring_hash.keys[0]
    best_scoring_visitor = away_teams_average_scoring_hash[final_id]
    
    away_teams_average_scoring_hash.each do |id, average|
      if average > best_scoring_visitor
        best_scoring_visitor = average
        final_id = id
      end
    end
    @teams.find {|team| team[:team_id] == final_id}[:teamname]
  end
    
    
  def lowest_scoring_visitor
    lowest_id = away_teams_average_scoring_hash.keys[2]
    worst_scoring_visitor = away_teams_average_scoring_hash[lowest_id]
    
    away_teams_average_scoring_hash.each do |id, average_score|
      if average_score < worst_scoring_visitor
        worst_scoring_visitor = average_score
        lowest_id = id
      end
    end
    @teams.find {|team| team[:team_id] == lowest_id}[:teamname]
  end

  def home_games_per_team
    number_of_games = []
    @games.map do |game|
      number_of_games << game[:home_team_id]
    end
    number_of_games.tally
  end
  
  def home_teams_average_scoring_hash
    home_scores_hash = Hash.new(0)
    home_teams_average_scoring_hash = {}
    
    @games.each do |game|
      home_scores_hash[game[:home_team_id]] += (game[:home_goals].to_f)
      
      home_scores_hash.map do |key, value|
        home_scores_hash[key] = value.round(2) 
      end
    end
    
    home_scores_hash.each do |home_id, score_value|
      home_games_per_team.each do |games_id, game_value|
        if games_id == home_id
          home_teams_average_scoring_hash[home_id] = (score_value/game_value).round(2)
        end
      end
    end
    home_teams_average_scoring_hash
  end
  
  def highest_scoring_home_team
    final_id = home_teams_average_scoring_hash.keys[0]
    best_scoring_home_team = home_teams_average_scoring_hash[final_id]
    
    home_teams_average_scoring_hash.each do |id, average|
      if average > best_scoring_home_team
        best_scoring_home_team = average
        final_id = id
      end
    end
    @teams.find {|team| team[:team_id] == final_id}[:teamname]
  end

  def lowest_scoring_home_team
    lowest_id = home_teams_average_scoring_hash.keys.last
    worst_scoring_home_team = home_teams_average_scoring_hash[lowest_id]
    
    home_teams_average_scoring_hash.each do |id, average_score|
      if average_score < worst_scoring_home_team
        worst_scoring_home_team = average_score
        lowest_id = id
      end
    end
    @teams.find {|team| team[:team_id] == lowest_id}[:teamname]
  end

  def most_tackles(season)
    tackles_by_season = Hash.new(0)
    games_group_by_season = @games.group_by do |game|
      game[:season]
    end
    game_ids = games_group_by_season[season].map do |game|
      game[:game_id]
    end
    game_teams_group_by_game_id = @game_teams.group_by do |game_team|
      game_team[:game_id]
    end
    game_ids.each do |id|
      @game_teams.each do |game_team|
        if game_team[:game_id] == id
          tackles_by_season[game_team[:team_id]] += game_team[:tackles]
        end
      end
    end
    team_with_most_tackles= tackles_by_season.max_by do |team_tackles|
      team_tackles[1]
    end.first
    @teams.find {|team| team[:team_id] == team_with_most_tackles}[:teamname]
  end

  def fewest_tackles(season)
    tackles_by_season = Hash.new(0)
    games_group_by_season = @games.group_by do |game|
      game[:season]
    end
    game_ids = games_group_by_season[season].map do |game|
      game[:game_id]
    end
    game_teams_group_by_game_id = @game_teams.group_by do |game_team|
      game_team[:game_id]
    end
    game_ids.each do |id|
      @game_teams.each do |game_team|
        if game_team[:game_id] == id
          tackles_by_season[game_team[:team_id]] += game_team[:tackles]
        end
      end
    end
    team_with_most_tackles= tackles_by_season.min_by do |team_tackles|
      team_tackles[1]
    end.first
    @teams.find {|team| team[:team_id] == team_with_most_tackles}[:teamname]
  end

  def average_win_percentage(id)
    games_by_the_team = @game_teams.find_all do |game_team|
      game_team[:team_id] == id
    end

    number_of_winning_games = games_by_the_team.count do |game|
        game[:result] == "WIN"
    end
    (number_of_winning_games/games_by_the_team.count.to_f).round(2)
  end

  def best_offense
    games_by_teams = @game_teams.group_by { |game_team| game_team[:team_id] }
    
    percent_team_goals = games_by_teams.transform_values do |games_by_team| 
      total_goals = games_by_team.sum do |game|
        game[:goals]
      end
      (total_goals.to_f/games_by_team.count).round(2)
    end
    best_offense_id = percent_team_goals.max_by { |percent_team_goal| percent_team_goal[1]}.first
    @teams.find {|team| team[:team_id] == best_offense_id}[:teamname]
  end

  def worst_offense
    games_by_teams = @game_teams.group_by { |game_team| game_team[:team_id] }
    
    percent_team_goals = games_by_teams.transform_values do |games_by_team| 
      total_goals = games_by_team.sum do |game|
        game[:goals]
      end
      (total_goals.to_f/games_by_team.count).round(2)
    end
    worst_offense_id = percent_team_goals.min_by { |percent_team_goal| percent_team_goal[1]}.first
    @teams.find {|team| team[:team_id] == worst_offense_id}[:teamname]
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
 
  def winningest_coach(season)
    season_coach_records(season).max_by { |coach| coach[1] }[0]
  end

  def worst_coach(season)
    season_coach_records(season).min_by { |coach| coach[1] }[0]
  end

  def season_games(season)
    @games.select { |game| game[:season] == season }
  end

  def season_game_teams(season)
    @game_teams.select { |game_team| game_team[:game_id][0..3] == season[0..3] }
  end

  def season_coaches(season)
    season_coaches = []

    season_games(season).each do |season_game|
      season_game[:game_id]
      season_game_teams(season).each do |season_game_team| 
        season_coaches << season_game_team[:head_coach] unless season_coaches.include?(season_game_team[:head_coach])
      end
    end

    season_coaches
  end

  def season_coach_records(season)
    season_coach_records = {}

    season_coaches(season).each do |season_coach|
      coach_season_games = season_game_teams(season).select { |game_team| game_team[:head_coach] == season_coach } 
      coach_season_wins = coach_season_games.count { |game| game[:result] == "WIN" }
      coach_season_total_games = coach_season_games.length
      season_coach_records[season_coach] = coach_season_wins / coach_season_total_games.to_f * 100 
    end
 
    season_coach_records
  end

  def best_season(team_id)
    team_games = @games.select { |game| game[:away_team_id] == team_id || game[:home_team_id] == team_id }
    team_season_games = team_games.group_by { |team_game| team_game[:season] }
    
    team_season_game_teams = team_season_games.transform_values do |team_season_games|
      team_games = []
      team_season_games.map do |team_season_game| 
        team_games << game_teams.find { |game_team| game_team[:game_id] == team_season_game[:game_id] &&
                                                    game_team[:team_id] == team_id }
      end
      team_games
    end

    team_season_win_percentage = team_season_game_teams.transform_values do |team_season_game_teams|
      team_season_game_teams.count { |team_season_game_team| team_season_game_team[:result] == "WIN" }.to_f / team_season_game_teams.count
    end

    team_season_win_percentage.max_by { |season| season[1] }[0]
  end

  def worst_season(team_id)
    team_games = @games.select { |game| game[:away_team_id] == team_id || game[:home_team_id] == team_id }
    team_season_games = team_games.group_by { |team_game| team_game[:season] }
    
    team_season_game_teams = team_season_games.transform_values do |team_season_games|
      team_games = []
      team_season_games.map do |team_season_game| 
        team_games << game_teams.find { |game_team| game_team[:game_id] == team_season_game[:game_id] &&
                                                    game_team[:team_id] == team_id }
      end
      team_games
    end

    team_season_win_percentage = team_season_game_teams.transform_values do |team_season_game_teams|
      team_season_game_teams.count { |team_season_game_team| team_season_game_team[:result] == "WIN" }.to_f / team_season_game_teams.count
    end

    team_season_win_percentage.min_by { |season| season[1] }[0]
  end

  def team_info(team_id)
    team = @teams.find { |team| team[:team_id] == team_id }

    hash = { 
      "team_id" => team[:team_id],
      "franchise_id" => team[:franchiseid],
      "team_name" => team[:teamname],
      "abbreviation" => team[:abbreviation],
      "link" => team[:link]
    }
  end
end
