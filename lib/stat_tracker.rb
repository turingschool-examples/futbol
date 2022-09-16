require 'csv'

class StatTracker

  attr_reader :game_path, :team_path, :game_teams_path

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    @game_csv = CSV.read(@game_path, headers: true, header_converters: :symbol)
    @team_csv = CSV.read(@team_path, headers: true, header_converters: :symbol)
    @game_teams_csv = CSV.read(@game_teams_path, headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end

  def list_team_ids
    @team_csv.map { |row| row[:team_id] }
  end

  def list_team_names_by_id(id)
    @team_csv.each { |row| return row[:teamname] if id.to_s == row[:team_id] }
  end

  def highest_total_score
    @game_csv.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }.max
  end

  def lowest_total_score
    @game_csv.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }.min
  end

  def percentage_home_wins
    home_wins = 0
    total_wins = 0
    @game_csv.each do |row|
      home_wins += 1 if row[:home_goals].to_f > row[:away_goals].to_f
      total_wins += 1
    end
    return (home_wins.to_f/total_wins.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    total_wins = 0
    @game_csv.each do |row|
      visitor_wins += 1 if row[:home_goals].to_f < row[:away_goals].to_f
      total_wins += 1
    end
    return (visitor_wins.to_f/total_wins.to_f).round(2)
  end

  def percentage_ties
    ties = 0
    total_wins = 0
    @game_csv.each do |row|
      ties += 1 if row[:home_goals].to_f == row[:away_goals].to_f
      total_wins += 1
    end
    return (ties.to_f/total_wins.to_f).round(2)
  end

  def count_of_games_by_season
    seasons_with_games = Hash.new(0)
    @game_csv.each do |row|
      seasons_with_games[row[:season]] += 1
    end
    seasons_with_games
  end

  def average_goals_per_game
    total_games = 0
    average = 0
    total_goals = 0
    @game_csv.each do |row|
     total_goals += row[:home_goals].to_i + row[:away_goals].to_i
      total_games += 1
      average = (total_goals.to_f/total_games.to_f).round(2)
    end
    average
  end

  def average_goals_by_season
    seasons_with_games = Hash.new(0)
    @game_csv.each do |row|
      seasons_with_games[row[:season]] += (row[:away_goals].to_f + row[:home_goals].to_f)
    end
    seasons_averages = Hash.new(0)
    seasons_with_games.map do |season_id, total_games|
      seasons_averages[season_id] = (total_games/self.count_of_games_by_season[season_id]).round(2)
    end
   p seasons_averages

  end

  def team_info(id)
    team_hash = Hash.new(0)

    @team_csv.each { |row| 
      if row[:team_id] == id
        team_hash['team_id'] = row[:team_id]
        team_hash['franchise_id'] = row[:franchiseid]
        team_hash['team_name'] = row[:teamname]
        team_hash['abbreviation'] = row[:abbreviation]
        team_hash['link'] = row[:link]
      end
    }
    
    return team_hash
  end

  def best_season(id)
    team_seasons = Hash.new(0)
    @game_teams_csv.each do |row| 
      if row[:team_id] == id
        if row[:result] == "WIN"
          season = @game_csv.find { |game| game[:game_id] == row[:game_id] }
          team_seasons[season[:season]] += 1
        end
      end
    end
    team_seasons.key(team_seasons.values.max)
  end

  def worst_season(id)
    team_seasons = Hash.new(0)
    @game_teams_csv.each do |row| 
      if row[:team_id] == id
        if row[:result] == "WIN" 
          season = @game_csv.find { |game| game[:game_id] == row[:game_id] }
          team_seasons[season[:season]] += 1
        end
      end
    end
    team_seasons.key(team_seasons.values.min)
  end

  def average_win_percentage(id)
    total_games = 0
    total_wins = 0 
    
    @game_teams_csv.each do |row|
      if row[:team_id] == id 
        total_wins += 1 if row[:result] == "WIN"
        total_games += 1
      end
    end
    
    return (total_wins.to_f / total_games.to_f).round(2)
  end

  def most_goals_scored(id)
    highest_score = 0 
    @game_teams_csv.each do |row|
      if row[:team_id] == id 
        highest_score = row[:goals].to_i if row[:goals].to_i > highest_score
      end
    end
    return highest_score
  end

  def fewest_goals_scored(id)
    lowest_score = self.most_goals_scored(id)
    @game_teams_csv.each do |row|
      if row[:team_id] == id 
        lowest_score = row[:goals].to_i if row[:goals].to_i < lowest_score
      end
    end
    return lowest_score
  end

  def favorite_opponent(id)
    
  end
end
