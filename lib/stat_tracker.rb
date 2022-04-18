require "csv"
require_relative "./game_teams"
require_relative "./games"
require_relative "./teams"

class StatTracker
  attr_reader :teams, :game_teams, :games

  def initialize(stat_tracker)
    @games = Games.new(stat_tracker[:games])
    # binding.pry
    @teams = Teams.new(stat_tracker[:teams])
    @game_teams = GameTeams.new(stat_tracker[:game_teams])
  end

  def self.from_csv(locations)
    stats = {}
    locations.each do |file_key, location_value|
      file = CSV.read(location_value, headers: true, header_converters: :symbol)
      stats[file_key] = file
    end
    StatTracker.new(stats)
    # stat_tracker = StatTracker.new(locations)
    # stat_tracker.games = Game.create_list_of_game(stat_tracker.games_csv)
  end


  def team_info(team_id)
    teams.by_id(team_id)
  end

  def best_season(team_id_number)
    # creates hash with team ids as keys and an empty hash as the value
    team_id_hash = Hash.new(0)
    win_percentage_hash = Hash.new(0)
    @teams.team_id.each do |team|
      team_id_hash[team] = Hash.new(0)
      win_percentage_hash[team] = Hash.new(0)
    end

    # for each team id in team_id_hash creates a hash with seasons as keys and the value is a hash with win/lose/tie/total keys
    @games.season.each_with_index do |season, index|
      team_id_hash.each do |key, value|
        if @games.away_team_id[index] == key
          team_id_hash[@games.away_team_id[index]][season] = {win: 0, lose: 0, tie: 0, total: 0}
        elsif @games.home_team_id[index] == key
          team_id_hash[@games.home_team_id[index]][season] = {win: 0, lose: 0, tie: 0, total: 0}
        end
      end
    end

    # adds win/lose/tie/total to each season
    @games.away_goals.each_with_index do |score, index|
      if score.to_i > @games.home_goals[index].to_i
        team_id_hash[@games.away_team_id[index]][@games.season[index]][:win] += 1
        team_id_hash[@games.home_team_id[index]][@games.season[index]][:lose] += 1
      elsif score.to_i < @games.home_goals[index].to_i
        team_id_hash[@games.home_team_id[index]][@games.season[index]][:win] += 1
        team_id_hash[@games.away_team_id[index]][@games.season[index]][:lose] += 1
      elsif score.to_i == @games.home_goals[index].to_i
        team_id_hash[@games.home_team_id[index]][@games.season[index]][:tie] += 1
        team_id_hash[@games.away_team_id[index]][@games.season[index]][:tie] += 1
      end
      team_id_hash[@games.away_team_id[index]][@games.season[index]][:total] += 1
      team_id_hash[@games.home_team_id[index]][@games.season[index]][:total] += 1
    end

    # adds win percentage based on win/total
    team_id_hash.each do |team_id_key, season_hash_values|
      season_hash_values.each do |season_key, hash_values|
        win_percentage = (hash_values[:win].to_f / hash_values[:total].to_f).round(2)
        hash_values[:win_percentage] = win_percentage
      end
    end

    # creates a hash of team id with a hash of season => win_percentage key/value pairs
    team_id_hash.each do |id_key, season_value|
      season_value.each do |season, values|
        win_percentage_hash[id_key][season] = values[:win_percentage]
      end
    end

    # returns the highest winning percent season
    best = win_percentage_hash[team_id_number.to_s].max_by { |k, v| v }
    best[0]
  end

  def most_goals_scored(team_id)
    # @game_teams.goals_array(team_id).max
    max_goals = Hash.new
    goals_by_id = Array.new
    binding.pry
    @game_teams.each do |row|
      team_hash = row.to_h
      max_goals[team_hash[:team_id]] = goals_by_id
      if team_hash[:team_id] == team_id
        goals_by_id << team_hash[:goals]
      end
    end
    max_goals[team_id].max



    # max_goals = Hash.new
    # goals_by_id = Array.new
    #
    # game_teams.gt_by_id(team_id).find_all
    #   max_goals[team_id] = goals_by_id
    #   goals_by_id << game_teams.gt_by_id(team_id)[:goals]
    #   max_goals[team_id].max.to_i
    end
  end

  # Start Game Statistics methods
  def highest_total_score
    @games.total_scores.max
  end

  def lowest_total_score
    @games.total_scores.min
  end

  def percentage_home_wins
    (@games.game_outcomes[:home_win].to_f / @games.game_outcomes[:total].to_f).round(2)
  end

  def percentage_visitor_wins
    (@games.game_outcomes[:away_win].to_f / @games.game_outcomes[:total].to_f).round(2)
  end

  def percentage_ties
    (@games.game_outcomes[:tie].to_f / @games.game_outcomes[:total].to_f).round(2)
  end

  def count_of_games_by_season
    @games.games_by_season_hash[:count]
  end

  def average_goals_per_game
    (@games.total_scores.sum.to_f / @games.total_scores.count.to_f).round(2)
  end

  def average_goals_by_season
    @games.games_by_season_hash[:average_goals]
  end
  # End Game Statistics methods
# end
