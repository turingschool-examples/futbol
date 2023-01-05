require 'csv'

class StatTracker
  attr_reader :data_array,
              :games,
              :teams,
              :game_teams


  def self.from_csv(locations)
    @data_array = locations.values.map {|location| location }
    @stat_tracker = StatTracker.new(@data_array)
  end

  def initialize(data_array)
    @data_array = data_array
    @games = CSV.read @data_array[0], headers: true, header_converters: :symbol
    @teams = CSV.read @data_array[1], headers: true, header_converters: :symbol
    @game_teams = CSV.read @data_array[2], headers: true, header_converters: :symbol
  end

  def highest_total_score
    @games.map {|row| row[:home_goals].to_i + row[:away_goals].to_i}.max
  end

  def lowest_total_score
    @games.map {|row| row[:home_goals].to_i + row[:away_goals].to_i}.min
  end

  def count_of_teams
   @teams.count
  end

  def nested_hash_creator
    Hash.new {|h,k| h[k] = Hash.new(0) }
  end

  def team_id_to_name(id)
    @teams.find { |team| team[:team_id] == id }[:teamname]
  end


def best_offense
  hash1 = nested_hash_creator
  hash2 = Hash.new(0)
  game_teams.each do |row|
    hash1[row[:team_id]][:games] += 1
    hash1[row[:team_id]][:goals] += row[:goals].to_i
  end
  hash1.each do |key, value|
    hash2[key] =  value[:goals].to_f / value[:games].to_f
  end

  highest_goals_average = hash2.values.max

  highest_scoring_id = hash2.find do |key, value|
    value == highest_goals_average
  end[0]

  team_id_to_name(highest_scoring_id)
end

def worst_offense
  hash1 = nested_hash_creator
  hash2 = Hash.new(0)
  game_teams.each do |row|
    hash1[row[:team_id]][:games] += 1
    hash1[row[:team_id]][:goals] += row[:goals].to_i
  end
  hash1.each do |key, value|
    hash2[key] =  value[:goals].to_f / value[:games].to_f
  end

  lowest_goals_average = hash2.values.min
  lowest_scoring_id = hash2.find do |key, value|
    value == lowest_goals_average
  end[0]

  team_id_to_name(lowest_scoring_id)
end


def most_tackles(season_id)
  games_list = []
  teams_tackles_hash = Hash.new(0)
  
  @games.each do |row|
    if row[:season] == season_id
      games_list << row[:game_id] 
    end
  end

  @game_teams.each do |row|
    if games_list.include?(row[:game_id])
      teams_tackles_hash[row[:team_id]] += row[:tackles].to_i
    end
  end
  
  highest_tackling_team_id = teams_tackles_hash.max_by{|k,v| v}[0]
  team_id_to_name(highest_tackling_team_id)
      
end

def fewest_tackles(season_id)
  games_list = []
  teams_tackles_hash = Hash.new(0)
  
  @games.each do |row|
    if row[:season] == season_id
      games_list << row[:game_id] 
    end
  end

  @game_teams.each do |row|
    if games_list.include?(row[:game_id])
      teams_tackles_hash[row[:team_id]] += row[:tackles].to_i
    end
  end

  lowest_tackling_team_id = teams_tackles_hash.min_by{|k,v| v}[0]
  team_id_to_name(lowest_tackling_team_id)
end


def list_games_by_season(season_id)
  games_list = []
  @games.each do |row|
    games_list << row[:game_id] if row[:season] == season_id
  end
  games_list
end



end




























