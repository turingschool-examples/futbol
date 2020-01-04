class Game

  @@all = []

  def self.all
    @@all
  end

  # For minitest only
  def self.reset_all
    @@all = []
  end
  # for MiniTest only

  attr_reader :id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link,
              :stats

  def initialize(game_info, stat_array)
    @id = game_info[:game_id].to_i
    @season = game_info[:season].to_i
    @type = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id].to_i
    @home_team_id = game_info[:home_team_id].to_i
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
    @venue = game_info[:venue]
    @venue_link = game_info[:venue_link]
    @stats = stat_results(stat_array)
    @@all << self
  end

  def stat_results(stat_array)
    stat_array.reduce({}) do |acc, inner_hash|
      acc[inner_hash[:team_id]] = inner_hash.slice(:HOA, :Coach, :Shots, :Tackles)
      acc
    end
  end

  def total_score
    @away_goals + @home_goals
  end

  def score_difference
    (@home_goals - @away_goals).abs
  end

  def winner
    return @home_team_id if @home_goals > @away_goals
    return @away_team_id if @away_goals > @home_goals
    return nil
  end
end
