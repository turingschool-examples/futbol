require "csv"

class StatTracker
  attr_accessor :games_reader,
              :game_teams_reader,
              :teams_reader

  def initialize
    @teams_reader = nil
    @games_reader = nil
    @game_teams_reader = nil
  end

  def self.from_csv(locations)
    stat_tracker = new
    stat_tracker.teams_reader = CSV.read locations[:teams], headers: true, header_converters: :symbol
    stat_tracker.games_reader = CSV.read locations[:games], headers: true, header_converters: :symbol
    stat_tracker.game_teams_reader = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    stat_tracker
  end

  def count_of_teams
   counter = 0
   @teams_reader.each do |row|
    counter += 1
   end
   counter
  end

  # Method to return the average number of goals scored in a game across all
  # seasons including both home and away goals (rounded to the nearest 100th)
  def average_goals_per_game
    total_goals = 0
    @games_reader.each do |game|
      total_goals += game[:away_goals].to_f
      total_goals += game[:home_goals].to_f
    end
    (total_goals / @games_reader.count).round(2)
  end

  # Method to return the average number of goals scored in a game organized in
  # a hash with season names as keys and a float representing the average number
  # of goals in a game for that season as values (rounded to the nearest 100th)
  def average_goals_by_season
    goals_per_season = Hash.new(0)
    @games_reader.each do |game|
      goals_per_season[game[:season]] += (game[:away_goals]).to_f
      goals_per_season[game[:season]] += (game[:home_goals]).to_f
    end
    goals_per_season.update(goals_per_season) do |season, total_goals|
      (total_goals / ((@games_reader[:season].find_all {|element| element == season}).count)).round(2)
    end
  end

  # Method to return name of the team with the highest average number of goals
  # scored per game across all seasons.
  def best_offense
    teams_hash = total_goals_by_team
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / ((@games_reader[:away_team_id].find_all {|element| element == team_id}).count +
      @games_reader[:home_team_id].find_all {|element| element == team_id}.count)
    end
    team_name_from_id(teams_hash.key(teams_hash.values.max))
  end

  # Helper method to return a hash with team ID keys and total goals by team
  # values
  def total_goals_by_team
    teams_hash = Hash.new(0)
    @teams_reader[:team_id].each do |team|
      @games_reader.each do |line|
        if line[:away_team_id] == team
          teams_hash[team] += line[:away_goals].to_f
        elsif line[:home_team_id] == team
          teams_hash[team] += line[:home_goals].to_f
        end
      end
    end
    teams_hash
  end

  # Helper method to return a team name from a team ID argument
  def team_name_from_id(team_id)
    @teams_reader[:teamname][@teams_reader[:team_id].index(team_id)]
  end

  # Method to return the name of the team with the lowest average number of
  # goals scored per game across all seasons.
  def worst_offense
    teams_hash = total_goals_by_team
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / ((@games_reader[:away_team_id].find_all {|element| element == team_id}).count +
      @games_reader[:home_team_id].find_all {|element| element == team_id}.count)
    end
    team_name_from_id(teams_hash.key(teams_hash.values.min))
  end

  # Method to return name of the team with the highest average score per game
  # across all seasons when they are home.
  def highest_scoring_home_team
    teams_hash = total_goals_by_team_by_at(:home_team_id)
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / @games_reader[:home_team_id].find_all {|element| element == team_id}.count
    end
    team_name_from_id(teams_hash.key(teams_hash.values.max))
  end

  # Method to return name of the team with the lowest average score per game
  # across all seasons when they are home.
  def lowest_scoring_home_team
    teams_hash = total_goals_by_team_by_at(:home_team_id)
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / @games_reader[:home_team_id].find_all {|element| element == team_id}.count
    end
    team_name_from_id(teams_hash.key(teams_hash.values.min))
  end

  # Helper method to retun hash with team_id as key and total goals at
  # home or away depending on the argument passed.
  def total_goals_by_team_by_at(at)
    teams_hash = Hash.new(0)
    @teams_reader[:team_id].each do |team|
      @games_reader.each do |line|
        teams_hash[team] += line[(at[0..4]).concat('goals').to_sym].to_f if line[at] == team
      end
    end
    teams_hash
  end

  # Method to return name of the team with the highest average score per game
  # across all seasons when they are away.
  def highest_scoring_visitor
    teams_hash = total_goals_by_team_by_at(:away_team_id)
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / @games_reader[:away_team_id].find_all {|element| element == team_id}.count
    end
    team_name_from_id(teams_hash.key(teams_hash.values.max))
  end

  # Method to return name of the team with the lowest average score per game
  # across all seasons when they are away.
  def lowest_scoring_visitor
    teams_hash = total_goals_by_team_by_at(:away_team_id)
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / @games_reader[:away_team_id].find_all {|element| element == team_id}.count
    end
    team_name_from_id(teams_hash.key(teams_hash.values.min))
  end

  def most_tackles(season)
    team_tackles = Hash.new(0)
    @teams_reader[:team_id].each do |team|
      @game_teams_reader.each do |line|
        team_tackles[team] += line[:tackles].to_i if line[:game_id][0..3] == season[0..3] && line[:team_id] == team
      end
    end
    team_name_from_id(team_tackles.key(team_tackles.values.max))
  end

  def fewest_tackles(season)
    team_tackles = Hash.new(0)
    @teams_reader[:team_id].each do |team|
      @game_teams_reader.each do |line|
        team_tackles[team] += line[:tackles].to_i if line[:game_id][0..3] == season[0..3] && line[:team_id] == team
      end
    end
    team_name_from_id(team_tackles.key(team_tackles.values.min))
  end
end
