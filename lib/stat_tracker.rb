require "csv"
require_relative './team'
require_relative './game'
require_relative './game_statistics'
require './lib/team_statistics'

class StatTracker
  include GameStatTracking
  include TeamStatTracking

  attr_accessor :games,
                :teams

  def initialize
    @games = Hash.new(0)
    @teams = Hash.new(0)
  end

  def self.from_csv(locations)
    stat_tracker = new
    team_csv_reader(locations, stat_tracker)
    game_csv_reader(locations, stat_tracker)
    game_teams_csv_reader(locations, stat_tracker)
    consolidate_team_data(stat_tracker)
    stat_tracker
  end

  def self.consolidate_team_data(stat_tracker)
    stat_tracker.games.each do |game_id, game_instance|
      stat_tracker.teams.each do |team_id, team_instance|
        if team_instance.team_games[game_id] != 0 && team_id == game_instance.away_team_id
          team_instance.team_games[game_id].opponent = game_instance.home_team_id
          team_instance.team_games[game_id].goals = game_instance.away_goals
          team_instance.team_games[game_id].result = game_instance.away_team[:result]
        elsif team_instance.team_games[game_id] != 0 && team_id == game_instance.home_team_id
          team_instance.team_games[game_id].opponent = game_instance.away_team_id
          team_instance.team_games[game_id].goals = game_instance.home_goals
          team_instance.team_games[game_id].result = game_instance.home_team[:result]
        end
      end
    end
  end

  def self.game_csv_reader(locations, stat_tracker)
    CSV.foreach locations[:games], headers: true, header_converters: :symbol do |row|
      stat_tracker.games[row[0].to_sym] = Game.new(row)
      stat_tracker.teams.each do |team_id, team_data|
        if team_id == stat_tracker.games[row[0].to_sym].away_team_id || team_id == stat_tracker.games[row[0].to_sym].home_team_id
          team_data.team_games[row[0].to_sym] = TeamGame.new(row)
        end
      end
    end
  end

  def self.game_teams_csv_reader(locations, stat_tracker)
    count = 0
    CSV.foreach locations[:game_teams], headers: true, header_converters: :symbol do |row|
      if count.even?
        stat_tracker.games[row[0].to_sym].import_away_team_data(row)
      elsif count.odd?
        stat_tracker.games[row[0].to_sym].import_home_team_data(row)
      end
      count += 1
    end
  end

  def self.team_csv_reader(locations, stat_tracker)
    CSV.foreach locations[:teams], headers: true, header_converters: :symbol do |row|
      stat_tracker.teams[row[0]] = Team.new(row)
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

  def worst_offense
    teams_hash = total_goals_by_team
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / ((@games_reader[:away_team_id].find_all {|element| element == team_id}).count +
      @games_reader[:home_team_id].find_all {|element| element == team_id}.count)
    end
    team_name_from_id(teams_hash.key(teams_hash.values.min))
  end

  def highest_scoring_home_team
    teams_hash = total_goals_by_team_by_at(:home_team_id)
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / @games_reader[:home_team_id].find_all {|element| element == team_id}.count
    end
    team_name_from_id(teams_hash.key(teams_hash.values.max))
  end

  def lowest_scoring_home_team
    teams_hash = total_goals_by_team_by_at(:home_team_id)
    teams_hash.update(teams_hash) do |team_id, total_goals|
      total_goals / @games_reader[:home_team_id].find_all {|element| element == team_id}.count
    end
    team_name_from_id(teams_hash.key(teams_hash.values.min))
  end

  def total_goals_by_team_by_at(at)
    teams_hash = Hash.new(0)
    @teams_reader[:team_id].each do |team|
      @games_reader.each do |line|
        teams_hash[team] += line[(at[0..4]).concat('goals').to_sym].to_f if line[at] == team
      end
    end
    teams_hash
  end

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

  def count_of_teams
   @teams_reader.length
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

  def coach_results(result, season_id)
    coaches = Hash.new(0.0)
    @game_teams_reader.each do |row|
      if row[:game_id][0..3] == season_id[0..3] && row[:result] == result
        coaches[row[:head_coach]] += 1.0
      end
    end
    coaches
  end

  def games_by_head_coach(season_id)
    games_by_coach = Hash.new(0)
    @game_teams_reader.each do |row|
      if row[:game_id][0..3] == season_id[0..3]
        games_by_coach[row[:head_coach]] += 1
      end
    end
    games_by_coach
  end

  def winningest_coach(season_id)
    coaches = coach_results("WIN", season_id)
    games_by_coach = games_by_head_coach(season_id)
    coach_win_percentages = Hash.new(0.0)
    games_by_coach.each do |coach, games|
      coach_win_percentages[coach] = (coaches[coach])/(games_by_coach[coach])
    end
    coach_win_percentages.key(coach_win_percentages.values.max)
  end

  def worst_coach(season_id)
    coaches = coach_results("WIN", season_id)
    games_by_coach = games_by_head_coach(season_id)
    coach_win_percentages = Hash.new(0.0)
    games_by_coach.each do |coach, games|
      coach_win_percentages[coach] = (coaches[coach])/(games_by_coach[coach])
    end
    coach_win_percentages.key(coach_win_percentages.values.min)
  end

  # Helper method to return hash of teams with team id keys and values of
  # total goals for the season
  def total_goals_by_team_season(season)
    team_scores = Hash.new(0)
    teams_array = @teams_reader[:team_id]
    teams_array.each do |team|
      @game_teams_reader.each do |line|
        team_scores[team] += (line[:goals]).to_i if line[:team_id] == team && line[:game_id][0..3] == season[0..3]
      end
    end
    team_scores
  end

  # Helper method to return hash of teams with team id keys and values of
  # total shots for the season
  def total_shots_by_team_season(season)
    teams_array = @teams_reader[:team_id]
    team_shots = Hash.new(0)
    teams_array.each do |team|
      @game_teams_reader.each do |line|
        team_shots[team] += line[:shots].to_f if line[:team_id] == team && line[:game_id][0..3] == season[0..3]
      end
    end
    team_shots
  end

  # Method to return the name of the Team with the best ratio of shots to goals
  # for the season
  def most_accurate_team(season)
    team_scores = accuracy_by_team_season(season)
    team_name_from_id(team_scores.key(team_scores.values.max))
  end

  # Method to return the name of the Team with the worst ratio of shots to goals
  # for the season
  def least_accurate_team(season)
    team_scores = accuracy_by_team_season(season)
    team_name_from_id(team_scores.key(team_scores.values.min))
  end

  # Helper method to return hash of teams with team id keys and values of
  # goals / shots for the season
  def accuracy_by_team_season(season)
    team_scores = total_goals_by_team_season(season)
    team_shots = total_shots_by_team_season(season)
    team_scores.update(team_scores) do |team, goals|
      goals / team_shots[team]
    end
    team_scores
  end
end
