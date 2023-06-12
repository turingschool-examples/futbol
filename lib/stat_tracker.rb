require "csv"
require_relative 'team_factory'
require_relative 'game_teams_factory'
require_relative 'game_factory'

class StatTracker 
  
  def self.from_csv(locations)
    game_factory = create_games_factory(locations[:games])
    team_factory = create_teams_factory(locations[:teams])
    game_teams_factory = create_game_teams_factory(locations[:game_teams])
    StatTracker.new(game_factory, team_factory, game_teams_factory)
  end

  def self.create_teams_factory(path)
    team_factory = TeamFactory.new
    team_factory.create_teams(path)
    team_factory
  end
  
  def self.create_games_factory(path)
    game_factory = GameFactory.new
    game_factory.create_games(path)
    game_factory
  end

  def self.create_game_teams_factory(path)
    game_teams_factory = GameTeamsFactory.new
    game_teams_factory.create_game_teams(path)
    game_teams_factory
  end

  def initialize(game_factory, team_factory, game_teams_factory)
    @game_factory = game_factory
    @team_factory = team_factory
    @game_teams_factory = game_teams_factory
  end

  def percentage_home_wins
    home_wins = 0 
    @game_factory.games.each do |game|
      if game[:home_goals] > game[:away_goals]
        home_wins += 1
      end
    end
    percentage_wins = (home_wins.to_f / @game_factory.games.count.to_f)
    percentage_wins.round(2)
  end
  
  def percentage_ties
    ties = @game_factory.games.count do |game|
      game[:away_goals] == game[:home_goals]
    end
    (ties.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0 
    @game_factory.games.each do |game|
      if game[:away_goals] > game[:home_goals]
        visitor_wins += 1
      end
    end
    percentage_wins = (visitor_wins.to_f / @game_factory.games.count.to_f)
    percentage_wins.round(2)
  end

  def percentage_ties
    @game_factory.percentage_ties
  end

  def best_offense
    best_offense_team_id = goals_per_team.max_by { |team_id, goals| goals }[0]
    best_team = @team_factory.teams.find do |team|
      if best_offense_team_id == team[:team_id]
        team
      end
    end
    best_team[:team_name]  
  end

  def average_goals_per_game
    all_goals = []
    @game_factory.games.each do |game|
      all_goals << game[:away_goals].to_i + game[:home_goals].to_i
    end
    total_goals = all_goals.sum
    amount_of_games = all_goals.count
    average_goals = total_goals.to_f / amount_of_games
    average_goals.round(2)
  end
  
  def average_goals_by_season
    goals_by_season = {}
    @game_factory.games.each do |game|
      goals_by_season[game[:season]] = []
    end
    @game_factory.games.each do |game|
      all_goals = game[:away_goals].to_i + game[:home_goals].to_i
      goals_by_season[game[:season]]<< all_goals
    end
    goals_by_season.transform_values! {|v| v.sum.to_f / v.count}
    goals_by_season.transform_values! {|v| v.round(2)}
  end
  
  #The first enumeration will assign a key to the @goals_by_season hash that is the number of the season and a value of and empty hash
  #The 2nd enumeration will gather all goals in game and then add them to the array value that is associated to that season
  #transform_values will display a new hash that averages then rounds
  
  def highest_scoring_visitor
    highest_scores = {}
    @game_factory.games.each do |game|
      if highest_scores[game[:away_team_id]] == nil
        highest_scores[game[:away_team_id]] = []
        highest_scores[game[:away_team_id]] << game[:away_goals].to_i
      else 
        highest_scores[game[:away_team_id]] << game[:away_goals].to_i
      end
    end
    highest_scores.transform_values! {|v| v.sum.to_f / v.count}
    highest_scores.transform_values! {|v| v.round(2)}
    top = highest_scores.values.find do |score|
      score == highest_scores.values.max
    end
    top_team_id = highest_scores.keys.find do |team|
      highest_scores[team] == top
    end
    top_team = @team_factory.teams.find do |team|
      team[:team_id] == top_team_id
    end
    top_team[:team_name]
  end
  
  def highest_scoring_home_team
    highest_scores = {}
    @game_factory.games.each do |game|
      if highest_scores[game[:home_team_id]] == nil
        highest_scores[game[:home_team_id]] = []
        highest_scores[game[:home_team_id]] << game[:home_goals].to_i
      else 
        highest_scores[game[:home_team_id]] << game[:home_goals].to_i
      end
    end
    highest_scores.transform_values! {|v| v.sum.to_f / v.count}
    highest_scores.transform_values! {|v| v.round(2)}
  
    top = highest_scores.values.find do |score|
      score == highest_scores.values.max
    end
    top_team_id = highest_scores.keys.find do |team|
      highest_scores[team] == top
    end
    top_team = @team_factory.teams.find do |team|
      team[:team_id] == top_team_id
    end
    top_team[:team_name]
  end
  
  # #This method starts with a hash where the key is the team_id and the value is an array of the goals if home/away
  # #The value is then summed, averaged, and rounded.
  # #top is equal to the highest average score per game
  # #top_team_id finds the team_id associated with the highest average score per game
  # #The method then searches the othe csv to find the team associated with that team_id and assigns them to top_team
  # #return top_team[:team_name] for a string that represents the team name.
  
  def most_tackles(season_id)
    games_per_season = @game_factory.games.find_all do |game|
      game if game[:season] == season_id
    end

    game_teams_per_season = []
    games_per_season.each do |game|
      @game_teams_factory.game_teams.each do |game_team|
        game_teams_per_season.push(game_team) if game[:game_id] == game_team[:game_id]
      end
    end

    tackles_by_team = Hash.new(0)
    game_teams_per_season.each do |game_team|
      tackles_per_team = game_team[:tackles].to_i
      tackles_by_team[game_team[:team_id]] += tackles_per_team
    end
    
    highest_tackle_team = tackles_by_team.max_by {|team, tackles| tackles}[0]
    highest_tackle_team_that_season = @team_factory.teams.find do |team| 
      team if highest_tackle_team == team[:team_id]
    end
    highest_tackle_team_that_season[:team_name]
  end

  def fewest_tackles(season_id)
    games_per_season = @game_factory.games.find_all do |game|
      game if game[:season] == season_id
    end

    game_teams_per_season = []
    games_per_season.each do |game|
      @game_teams_factory.game_teams.each do |game_team|
        game_teams_per_season.push(game_team) if game[:game_id] == game_team[:game_id]
      end
    end

    tackles_by_team = Hash.new(0)
    game_teams_per_season.each do |game_team|
      tackles_per_team = game_team[:tackles].to_i
      tackles_by_team[game_team[:team_id]] += tackles_per_team
    end
    
    fewest_tackle_team = tackles_by_team.min_by {|team, tackles| tackles}[0]
    fewest_tackle_team_that_season = @team_factory.teams.find do |team| 
      team if fewest_tackle_team == team[:team_id]
    end
    fewest_tackle_team_that_season[:team_name]
  end

  def most_accurate_team(season_id)
    games_per_season = @game_factory.games.find_all do |game|
      game if game[:season] == season_id
    end

    game_teams_per_season = []
    games_per_season.each do |game|
      @game_teams_factory.game_teams.each do |game_team|
        game_teams_per_season.push(game_team) if game[:game_id] == game_team[:game_id]
      end
    end
    
    avg_by_team = Hash.new(0)
    game_teams_per_season.each do |game_team|
      avg_per_game = game_team[:goals].to_f / game_team[:shots].to_i
      avg_by_team[game_team[:team_id]] += avg_per_game
    end

    avg_overall = Hash.new(0)
    avg_by_team.map do |team, avg|
      avg_overall[team] = avg / games_per_season.count
    end
    
    highest_accuracy_team = avg_overall.max_by {|team, avg| avg}[0]
    highest_team_that_season = @team_factory.teams.find do |team| 
      team if highest_accuracy_team == team[:team_id]
    end
    
    highest_team_that_season[:team_name]
  end

  def least_accurate_team(season_id)
    games_per_season = @game_factory.games.find_all do |game|
      game if game[:season] == season_id
    end

    game_teams_per_season = []
    games_per_season.each do |game|
      @game_teams_factory.game_teams.each do |game_team|
        game_teams_per_season.push(game_team) if game[:game_id] == game_team[:game_id]
      end
    end
    
    avg_by_team = Hash.new(0)
    game_teams_per_season.each do |game_team|
      avg_per_game = game_team[:goals].to_f / game_team[:shots].to_i
      avg_by_team[game_team[:team_id]] += avg_per_game
    end

    avg_overall = Hash.new(0)
    avg_by_team.map do |team, avg|
      avg_overall[team] = avg / games_per_season.count
    end
    lowest_accuracy_team = avg_overall.min_by {|team, avg| avg}[0]

    lowest_team_that_season = @team_factory.teams.find do |team| 
      team if lowest_accuracy_team == team[:team_id]
    end
    lowest_team_that_season[:team_name]
  end

  def worst_offense
    worst_offense_team_id = goals_per_team.min_by { |team_id, goals| goals }[0]
    worst_team = @team_factory.teams.find do |team|
      if worst_offense_team_id == team[:team_id]
        team
      end
    end
    worst_team[:team_name] 
  end

  def goals_per_team
    team_goals = Hash.new(0)
    @game_teams_factory.game_teams.each do |game|
      team_goals[game[:team_id]] += game[:goals].to_i
    end
    team_goals
  end

  def highest_sum 
    hash = {}
    @game_factory.games.each do |game|
      if hash.key?(game[:home_team_id])
        hash[game[:home_team_id]] += game[:home_goals].to_i
      else
        hash[game[:home_team_id]] = game[:home_goals].to_i
      end

      if hash.key?(game[:away_team_id])
        hash[game[:away_team_id]] += game[:away_goals].to_i
      else
        hash[game[:away_team_id]] = game[:away_goals].to_i
      end
    end
  hash.values.max
  end

  def lowest_sum 
    hash = {}
    @game_factory.games.each do |game|
      if hash.key?(game[:home_team_id])
        hash[game[:home_team_id]] += game[:home_goals].to_i
      else
        hash[game[:home_team_id]] = game[:home_goals].to_i
     end

      if hash.key?(game[:away_team_id])
        hash[game[:away_team_id]] += game[:away_goals].to_i
      else
        hash[game[:away_team_id]] = game[:away_goals].to_i
      end

    end
  hash.values.min
  end
  
  def look_up_team_name(team_id)
    team = @team_factory.teams.find do |team|
      team_id == team[:team_id]
    end
    team[:team_name]
  end

  def lowest_scoring_visitor
    lsv = @game_factory.games.min_by do |game|
      game[:away_goals]
    end
    look_up_team_name(lsv[:away_team_id])  
  end

  def count_of_teams 
    @team_factory.teams.count
  end


  def winningest_coach(season_id)
    games_per_season = @game_factory.games.find_all do |game|
      game if game[:season] == season_id
    end

    game_teams_per_season = []
    games_per_season.each do |game|
      @game_teams_factory.game_teams.each do |game_team|
        game_teams_per_season.push(game_team) if game[:game_id] == game_team[:game_id]
      end
    end

    wins_per_coach = Hash.new(0)
    game_teams_per_season.each do |game_team|
      wins_per_coach[game_team[:head_coach]] += 1 if game_team[:result] == "WIN"
    end
    
    wins_per_coach.max_by { |coach, wins| wins }[0] 
  end

  def worst_coach(season_id)
    games_per_season = @game_factory.games.find_all do |game|
      game if game[:season] == season_id
    end

    game_teams_per_season = []
    games_per_season.each do |game|
      @game_teams_factory.game_teams.each do |game_team|
        game_teams_per_season.push(game_team) if game[:game_id] == game_team[:game_id]
      end
    end

    losses_per_coach = Hash.new(0)
    game_teams_per_season.each do |game_team|
      losses_per_coach[game_team[:head_coach]] += 1 if game_team[:result] == "LOSS"
    end
    
    losses_per_coach.min_by { |coach, losses| losses }[0] 
  end
end
