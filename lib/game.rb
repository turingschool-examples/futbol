require_relative "hashable"
require_relative "gameable"
require_relative "winable"

require_relative 'collection'

class Game < Collection

  include Winable
  extend Hashable
  extend Gameable


  def self.highest_total_score
    all.map { |game| game.away_goals + game.home_goals}.max
  end

  def self.lowest_total_score
    all.map { |game| game.away_goals + game.home_goals}.min
  end

  def self.grouped_by_season(passed_in_season)
    all.select{|game| game.season == passed_in_season}
  end

  def self.count_of_games_by_season
    games_by_season = all.group_by { |game| game.season }
    count = {}
    games_by_season.keys.each do |key|
      count[key.to_s] = all.count { |game| game.season == key}
    end
    count
  end

  def self.average_goals_per_game
    sum = all.sum { |game| game.away_goals + game.home_goals}.to_f
    (sum / all.length.to_f).round(2)
  end

  def self.games_goals_by_season
    hash_of_hashes(all, :season, :goals, :games_played, :total_goals, 1)
  end

#deliverable
  def self.average_goals_by_season
    # :goals / :games_played
    divide_hash_values(:goals, :games_played, games_goals_by_season)
  end

#deliverable
  def self.average_goals_by(hoa_team)
    divide_hash_values(:goals, :games_played, games_goals_by(hoa_team))
  end

  def self.highest_scoring_visitor_team_id
    average_goals_by(:away_team).max_by{ |team_id, away_goals| away_goals}.first
  end

  def self.highest_scoring_home_team_id
    average_goals_by(:home_team).max_by{ |team_id, home_goals| home_goals}.first
  end

  def self.lowest_scoring_visitor_team_id
    average_goals_by(:away_team).min_by{ |team_id, away_goals| away_goals}.first
  end

  def self.lowest_scoring_home_team_id
    average_goals_by(:home_team).min_by{ |team_id, home_goals| home_goals}.first
  end

  def self.best_season(team_id)
    #return season with highest winning percentage
    best_season = win_percent_by_season(team_id).max_by { |season, percent| percent}
    best_season[0].to_s
  end

  def self.worst_season(team_id)
    #return season with lowest winning percentage
    worst_season = win_percent_by_season(team_id).min_by { |season, percent| percent}
      worst_season[0].to_s
  end

  def self.average_win_percentage(team_id)
    wins = games_played_by(team_id).map { |game| game.win?(team_id)}.sum
    avg = (wins / games_played_by(team_id).length.to_f).round(2)
  end

  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link,
              :total_goals

  def initialize(game_stats)
    @game_id = game_stats[:game_id]
    @season = game_stats[:season]
    @type = game_stats[:type]
    @date_time = game_stats[:date_time]
    @away_team_id = game_stats[:away_team_id]
    @home_team_id = game_stats[:home_team_id]
    @away_goals = game_stats[:away_goals].to_i
    @home_goals = game_stats[:home_goals].to_i
    @venue = game_stats[:venue]
    @venue_link = game_stats[:venue_link]
    @total_goals = @away_goals + @home_goals
  end

end
