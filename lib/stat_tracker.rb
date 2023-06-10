require "csv"
require_relative 'team_factory'
require_relative 'game_teams_factory'
require_relative 'game_factory'

class StatTracker 

  def from_csv(path)
    if path == './data/games.csv'
      @game_factory = create_games_factory(path)
    elsif path == './data/teams.csv'
      @team_factory = create_teams_factory(path)
    else
      @game_teams_factory = create_game_teams_factory(path)
    end
  end

  def create_teams_factory(path)
    team_factory = TeamFactory.new
    team_factory.create_teams(path)
    team_factory
  end
  
  def create_games_factory(path)
    game_factory = GameFactory.new
    game_factory.create_games(path)
    game_factory
  end

  def create_game_teams_factory(path)
    game_teams_factory = GameTeamsFactory.new
    game_teams_factory.create_game_teams(path)
    game_teams_factory
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
  
  def percent_of_ties
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
    team_goals = Hash.new(0)
    @game_teams_factory.game_teams.each do |game|
      team_goals[game[:team_id]] += game[:goals].to_i
    end
    best_offense_team_id = team_goals.max_by { |team_id, goals| goals }[0]
    best_team = @team_factory.teams.find do |team|
      if best_offense_team_id == team[:team_id]
        team
      end
    end
    best_team[:team_name]  
  end

  def average_goals_per_game(csv_array)
    csv_array.each do |game|
      @all_goals << game[:away_goals].to_i + game[:home_goals].to_i
    end
    total_goals = @all_goals.sum
    amount_of_games = @all_goals.count
    average_goals = total_goals.to_f / amount_of_games
    average_goals.round(2)
  end
  
  def average_goals_by_season(csv_array)
    csv_array.each do |game|
      @goals_by_season[game[:season]] = []
    end
    csv_array.each do |game|
      all_goals = game[:away_goals].to_i + game[:home_goals].to_i
      @goals_by_season[game[:season]]<< all_goals
    end
    @goals_by_season.transform_values! {|v| v.sum.to_f / v.count}
    @goals_by_season.transform_values! {|v| v.round(2)}
    require 'pry'; binding.pry
  end
  
  #The first enumeration will assign a key to the @goals_by_season hash that is the number of the season and a value of and empty hash
  #The 2nd enumeration will gather all goals in game and then add them to the array value that is associated to that season
  #transform_values will display a new hash that averages then rounds
  
  def highest_scoring_visitor(csv, csv2)
    highest_scores = {}
    csv.each do |game|
      if highest_scores[game[:away_team_id]] == nil
        highest_scores[game[:away_team_id]] = []
        highest_scores[game[:away_team_id]] << game[:away_goals].to_i
      else 
        highest_scores[game[:away_team_id]] << game[:away_goals].to_i
      end
    end
    highest_scores.transform_values! {|v| v.sum.to_f / v.count}
    highest_scores.transform_values! {|v| v.round(2)}
    require 'pry'; binding.pry
    top = highest_scores.values.find do |score|
      score == highest_scores.values.max
    end
    top_team_id = highest_scores.keys.find do |team|
      highest_scores[team] == top
    end
    top_team = csv2.find do |team|
      team[:team_id] == top_team_id
    end
    top_team[:team_name]
  end
  
  def highest_scoring_home_team(csv, csv2)
    highest_scores = {}
    csv.each do |game|
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
    top_team = csv2.find do |team|
      team[:team_id] == top_team_id
    end
    top_team[:team_name]
  end
  
  
  #This method starts with a hash where the key is the team_id and the value is an array of the goals if home/away
  #The value is then summed, averaged, and rounded.
  #top is equal to the highest average score per game
  #top_team_id finds the team_id associated with the highest average score per game
  #The method then searches the othe csv to find the team associated with that team_id and assigns them to top_team
  #return top_team[:team_name] for a string that represents the team name.
  
  def most_tackles(csv, csv2) 
    tackles_by_team = {}
    csv.each do |game|
      if tackles_by_team[game[:team_id]] == nil
        tackles_by_team[game[:team_id]] = []
        tackles_by_team[game[:team_id]] << game[:tackles].to_i
      else
        tackles_by_team[game[:team_id]] << game[:tackles].to_i
      end
    end
    tackles_by_team.transform_values! {|v| v.sum}
    highest_tackles = tackles_by_team.values.find do |tackle|
      tackle == tackles_by_team.values.max
    end
    top_tackle_team_id = tackles_by_team.find do |team|
      team[1]== highest_tackles
    end
    top_tackle_team = csv2.find do |team|
      team[:team_id] == top_tackle_team_id[0]
    end
    top_tackle_team[:team_name]
  end
  
  def fewest_tackles(csv, csv2) 
    tackles_by_team = {}
    csv.each do |game|
      if tackles_by_team[game[:team_id]] == nil
        tackles_by_team[game[:team_id]] = []
        tackles_by_team[game[:team_id]] << game[:tackles].to_i
      else
        tackles_by_team[game[:team_id]] << game[:tackles].to_i
      end
    end
    tackles_by_team.transform_values! {|v| v.sum}
    lowest_tackles = tackles_by_team.values.find do |tackle|
      tackle == tackles_by_team.values.min
    end
    least_tackle_team_id = tackles_by_team.find do |team|
      team[1]== lowest_tackles
    end
    least_tackle_team = csv2.find do |team|
      team[:team_id] == least_tackle_team_id[0]
    end
    least_tackle_team[:team_name]
  end
  
  def most_accurate_team(csv, csv2)
    accuracy_by_team = {}
    csv.each do |game|
      if accuracy_by_team[game[:team_id]] == nil
        accuracy_by_team[game[:team_id]] = []
        accuracy = game[:goals].to_f / game[:shots].to_i
        accuracy_by_team[game[:team_id]] << accuracy
      else
        accuracy = game[:goals].to_f / game[:shots].to_i
        accuracy_by_team[game[:team_id]] << accuracy
      end
    end
    accuracy_by_team.transform_values! {|v| v.sum / v.count }
    accuracy_by_team.transform_values! {|v| v.round(2)}
    highest_accuracy = accuracy_by_team.values.find do |accuracy|
      accuracy == accuracy_by_team.values.max
    end
    top_accuracy_team_id = accuracy_by_team.find do |team|
      team[1]== highest_accuracy
    end
    top_accuracy_team = csv2.find do |team|
      team[:team_id] == top_accuracy_team_id[0]
    end
    top_accuracy_team[:team_name]
  end
  
  def least_accurate_team(csv, csv2)
    accuracy_by_team = {}
    csv.each do |game|
      if accuracy_by_team[game[:team_id]] == nil
        accuracy_by_team[game[:team_id]] = []
        accuracy = game[:goals].to_f / game[:shots].to_i
        accuracy_by_team[game[:team_id]] << accuracy
      else
        accuracy = game[:goals].to_f / game[:shots].to_i
        accuracy_by_team[game[:team_id]] << accuracy
      end
    end
    accuracy_by_team.transform_values! {|v| v.sum / v.count }
    accuracy_by_team.transform_values! {|v| v.round(2)}
    lowest_accuracy = accuracy_by_team.values.find do |accuracy|
      accuracy == accuracy_by_team.values.min
    end
    least_accuracy_team_id = accuracy_by_team.find do |team|
      team[1]== lowest_accuracy
    end
    least_accuracy_team = csv2.find do |team|
      team[:team_id] == least_accuracy_team_id[0]
    end
    require 'pry'; binding.pry
    least_accuracy_team[:team_name]
  end



  
end
