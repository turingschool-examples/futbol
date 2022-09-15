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

  def average_goals_per_game
    total_goals = 0
    @games_reader.each do |game|
      total_goals += game[:away_goals].to_f
      total_goals += game[:home_goals].to_f
    end
    (total_goals / @games_reader.count).round(2)
  end

  def average_goals_by_season
    goals_per_season = Hash.new(0)
    @games_reader.each do |game|
      goals_per_season[game[:season]] += (game[:away_goals]).to_f
      goals_per_season[game[:season]] += (game[:home_goals]).to_f
    end
    goals_per_season.update(goals_per_season) do |season, total_goals|
      total_goals / ((@games_reader[:season].find_all {|element| element == season}).count)
    end
  end

  def best_offense
    teams_hash = total_goals_by_team
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / ((@games_reader[:away_team_id].find_all {|element| element == team_id}).count +
    @games_reader[:home_team_id].find_all {|element| element == team_id}.count)
    end
    team_name_from_id(teams_hash.key(teams_hash.values.max))
  end

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

  def team_name_from_id(team_id)
    @teams_reader[:teamname][@teams_reader[:team_id].index('20')]
  end
end
