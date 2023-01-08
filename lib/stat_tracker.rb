require 'CSV'

class StatTracker
  attr_reader :games,
              :teams, 
              :game_teams,
              :game_id,
              :total_score_array,
              :team_id
             
  def initialize(locations)
    @games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @total_score_array = total_score
    @team_id = @game_teams[:team_id]
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
   
  def total_score
    total_score_array = []
    @games.each do |row|
      total_score_array << row[:away_goals].to_i + row[:home_goals].to_i
    end
    total_score_array
  end

  def highest_total_score
    total_score
    @total_score_array.max
  end

  def lowest_total_score
    total_score
    @total_score_array.min
  end

  def percentage_home_wins
    count = @games.count do |row|
      row[:home_goals].to_i > row[:away_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end

  def percentage_visitor_wins
    count = @games.count do |row|
      row[:away_goals].to_i > row[:home_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end

  def percentage_ties
    count = @games.count do |row|
      row[:away_goals].to_i == row[:home_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end

  def count_of_teams
    @teams.length
  end

  def best_offense
    teams = []
    @games.each do |row|
      teams.push([row[:home_team_id], row[:home_goals]])
      teams.push([row[:away_team_id], row[:away_goals]])
    end

    hash = Hash.new {|hash, key| hash[key] = []}
    teams.each do |array|
      hash[array[0]] << array[1].to_i
    end

    hash.each do |k, v|
      if v.size > 1
        hash[k] = v.sum.to_f/v.size
      else
        hash[k] = v[0].to_f/1
      end
    end

    max_team = hash.max_by do |k, v|
      v
    end

    best_offense = nil
    @teams.each do |team|
      best_offense = team[:teamname] if team[:team_id] == max_team[0]
    end
    best_offense
  end

  def worst_offense
    teams = []
    @games.each do |row|
      teams.push([row[:home_team_id], row[:home_goals]])
      teams.push([row[:away_team_id], row[:away_goals]])
    end

    hash = Hash.new {|hash, key| hash[key] = []}
    teams.each do |array|
      hash[array[0]] << array[1].to_i
    end

    hash.each do |k, v|
      if v.size > 1
        hash[k] = v.sum.to_f/v.size
      else
        hash[k] = v[0].to_f/1
      end
    end

    min_team = hash.min_by do |k, v|
      v
    end

    worst_offense = nil
    @teams.each do |team|
      worst_offense = team[:teamname] if team[:team_id] == min_team[0]
    end
    worst_offense
  end
  
  
  def away_goals_by_team_id
    away_goals = Hash.new(0)
    @game_teams.each do |row|
      if row[:hoa] == "away"
        away_goals[row[:team_id]] += row[:goals].to_i
      end
      
    end
    away_goals 
  end

  def away_games_by_team_id
    away_games = Hash.new(0)
    @game_teams.each do |row|
      if row[:hoa] == "away"
        away_games[row[:team_id]] += 1
      end
      
    end
    away_games
  end

  def home_goals_by_team_id
    home_goals = Hash.new(0)
    @game_teams.each do |row|
      if row[:hoa] == "home"
        home_goals[row[:team_id]] += row[:goals].to_i
      end
      
    end
    home_goals 
  end

  def home_games_by_team_id
    home_games = Hash.new(0)
    @game_teams.each do |row|
      if row[:hoa] == "home"
        home_games[row[:team_id]] += 1
      end
      
    end
    home_games
  end

  def away_goal_avg_per_game
    hash = Hash.new(0)
    away_games_by_team_id.each do |teams1, games|
      away_goals_by_team_id.each do |teams2, goals|
        if teams1 == teams2
          hash[teams1] = (goals / games.to_f).round(2)
        end
      end
    end
    hash
  end

  def home_goal_avg_per_game
    hash = Hash.new(0)
    home_games_by_team_id.each do |teams1, games|
      home_goals_by_team_id.each do |teams2, goals|
        if teams1 == teams2
          hash[teams1] = (goals / games.to_f).round(2)
        end
      end
    end
    hash
  end

  def highest_scoring_visitor
    highest_visitor = away_goal_avg_per_game.max_by {|k, v| v}
    best_away_team = nil
    @teams.each do |team|
      if highest_visitor.first == team[:team_id]
        best_away_team = team[:teamname]
        
      end
    end
    best_away_team
  end

  def lowest_scoring_visitor
    highest_visitor = away_goal_avg_per_game.min_by {|k, v| v}
    best_away_team = nil
    @teams.each do |team|
      if highest_visitor.first == team[:team_id]
        best_away_team = team[:teamname]
        
      end
    end
    best_away_team
  end

  def highest_scoring_home_team
    highest_home_team = home_goal_avg_per_game.max_by {|k, v| v}
    best_home_team = nil
    @teams.each do |team|
      if highest_home_team.first == team[:team_id]
        best_home_team = team[:teamname]
        
      end
    end
    best_home_team
  end

  def lowest_scoring_home_team
    lowest_home_team = home_goal_avg_per_game.min_by {|k, v| v}
    best_home_team = nil
    @teams.each do |team|
      if lowest_home_team.first == team[:team_id]
        best_home_team = team[:teamname]
        
      end
    end
    best_home_team
  end


  def average_win_percentage(team)
    team_games = []
    won = []

    @game_teams.each do |game_team|
      if game_team[:team_id] == team
        team_games << game_team
      end
      team_games
    end

    team_games.each do |team_game|
      if team_game[:result] == 'WIN'
        won << team_game
      end
    end
    (won.count.to_f / team_games.count).round(2)
  end

  def goals_by_team_id(team_id)
    goals = []
   
    @game_teams.each do |game|
      goals << game[:goals].to_i if game[:team_id] == team_id
    end
    goals
  end

  def most_goals_scored(team_id)
    goals_by_team_id(team_id).sort.last
  end

  def fewest_goals_scored(team_id)
    goals_by_team_id(team_id).sort.first
  end
end













