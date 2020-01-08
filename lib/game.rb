require 'csv'
require_relative './csv_loadable'
require_relative './team'

class Game < Team
  extend CsvLoadable

  @@all_games = []
  @@team_id_scores = {}

  def self.all
    @@all_games
  end

  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue

  def self.from_csv(file_path)
    @@all_games = load_from_csv(file_path, Game)
  end

  def initialize(game_info)
    @game_id = game_info[:game_id]
    @season = game_info[:season]
    @type = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id].to_i
    @home_team_id = game_info[:home_team_id].to_i
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
    @venue = game_info[:venue]
  end

  def self.highest_total_score
    #refactor later
    max = @@all_games.max_by {|game| game.away_goals + game.home_goals }
    max.away_goals + max.home_goals
  end

  def self.lowest_total_score
    #refactor later
    min = @@all_games.min_by {|game| game.away_goals + game.home_goals }
    min.away_goals + min.home_goals
  end

  def self.biggest_blowout
    #refactor later
    difference = @@all_games.max_by {|game| (game.away_goals - game.home_goals).abs }
    (difference.away_goals - difference.home_goals).abs
  end

  def self.percentage_home_wins
    #refactor later
    home_wins = @@all_games.find_all {|game| game.home_goals > game.away_goals }
    (home_wins.length / @@all_games.length.to_f).round(2)
  end

  def self.percentage_visitor_wins
    #refactor later
    vis_wins = @@all_games.find_all {|game| game.home_goals < game.away_goals }
    (vis_wins.length / @@all_games.length.to_f).round(2)
  end

  def self.percentage_ties
    #refactor later
    ties = @@all_games.find_all {|game| game.home_goals == game.away_goals }
    (ties.length / @@all_games.length.to_f).round(2)
  end

  def self.count_of_games_by_season
    @@all_games.reduce({}) do |hash, game|
      if hash.keys.include?(game.season)
        hash[game.season] += 1
        hash
      else
        hash[game.season] = 1
        hash
      end
    end
  end

  def self.average_goals_per_game
    sums = @@all_games.sum do |game|
      (game.away_goals + game.home_goals)
    end
    (sums / @@all_games.length.to_f).round(2)
  end

  def self.average_goals_by_season
    games_by_season = count_of_games_by_season
    testy = @@all_games.reduce({}) do |hash, game|
      if hash.keys.include?(game.season)
        hash[game.season] += (game.away_goals + game.home_goals)
        hash
      else
        hash[game.season] = (game.away_goals + game.home_goals)
        hash
      end
    end
    games_by_season.reduce(Hash.new(0)) do |result, pair|
      result[pair[0]] = (testy[pair[0]] / pair[-1].to_f).round(2)
      result
      # require "pry"; binding.pry
    end
  end

  # Start of iteration 3
  def self.count_of_teams
    @@all_teams.count
  end

  def self.best_offense
    total_score_average_added_by_team
    max_value_team
  end

  def self.worst_offense
    total_score_average_added_by_team
    min_value_team
  end

  def self.best_defense
    total_points_allowed_by_team
    min_value_team
  end

  def self.worst_defense
    total_points_allowed_by_team
    max_value_team
  end

  def self.highest_scoring_visitor
    away_score_values_added_by_team
    max_value_team
  end

  def self.highest_scoring_home_team
    home_score_values_added_by_team
    max_value_team
  end

  def self.lowest_scoring_visitor
    away_score_values_added_by_team
    min_value_team
  end

  def self.lowest_scoring_home_team
    home_score_values_added_by_team
    min_value_team
  end

  def self.max_value_team
    team_id_average_scores
    team_id = @@team_id_scores.key(@@team_id_scores.values.max)
    team = @@all_teams.find {|team| team.team_name if team.team_id == team_id}
    team.team_name
  end

  def self.min_value_team
    team_id_average_scores
    team_id = @@team_id_scores.key(@@team_id_scores.values.min)
    team = @@all_teams.find {|team| team.team_name if team.team_id == team_id}
    team.team_name
  end


  def self.team_id_average_scores
    @@team_id_scores.each do |key, value|
      @@team_id_scores[key] = (value.sum / value.count.to_f).round(2)
    end
  end

  def self.team_id_scores_hash
    @@team_id_scores = @@all_teams.reduce({}) do |hash, team|
      hash[team.team_id] = []
      hash
    end
  end

  def self.total_score_average_added_by_team
    away_score_values_added_by_team
    home_score_values_added_by_team
  end

  def self.home_score_values_added_by_team
    @@team_id_scores = team_id_scores_hash
    @@all_teams.each do |team|
      @@all_games.each do |game|
        if team.team_id == game.home_team_id
          @@team_id_scores[team.team_id] << game.home_goals
        end
      end.compact
    end
  end

  def self.away_score_values_added_by_team
    @@team_id_scores = team_id_scores_hash
    @@all_teams.each do |team|
      @@all_games.each do |game|
        if team.team_id == game.away_team_id
          @@team_id_scores[team.team_id] << game.away_goals
        end
      end.compact
    end
  end

  def self.total_points_allowed_by_team
    @@team_id_scores = team_id_scores_hash
    away_points_allowed_by_home_team
    home_points_allowed_by_away_team
  end

  def self.away_points_allowed_by_home_team
    @@team_id_scores = team_id_scores_hash
    @@all_teams.each do |team|
      @@all_games.each do |game|
        if team.team_id == game.home_team_id
          @@team_id_scores[team.team_id] << game.away_goals
        end
      end.compact
    end
  end

  def self.home_points_allowed_by_away_team
    @@team_id_scores = team_id_scores_hash
    @@all_teams.each do |team|
      @@all_games.each do |game|
        if team.team_id == game.away_team_id
          @@team_id_scores[team.team_id] << game.home_goals
        end
      end.compact
    end
  end

  # def self.winner
  #   return @home_team_id if @home_goals > @away_goals
  #   @away_team_id
  # end

end
