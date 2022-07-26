require 'csv'

class StatTracker
  def self.from_csv(locations)
    all_data_hash = Hash.new{ |h, k| h[k] = [] }
    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      all_data_hash[:games] << row
    end
    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      all_data_hash[:teams] << row
    end
    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      all_data_hash[:game_teams] << row
    end
  new(all_data_hash)
  end

  def initialize(all_data_hash)
    @all_data_hash = all_data_hash
  end

  def highest_total_score
    total_scores = []
    @all_data_hash[:games].each do |row|
      home_goals = row[:home_goals].to_i
      away_goals = row[:away_goals].to_i
      total_scores << home_goals + away_goals
    end
    total_scores.max
  end

  def lowest_total_score
    total_scores = []
    @all_data_hash[:games].map do |row|
      home_goals = row[:away_goals].to_i
      away_goals = row[:home_goals].to_i
      total_scores << home_goals + away_goals
    end
    total_scores.min
  end
end
