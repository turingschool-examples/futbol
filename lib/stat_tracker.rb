require 'CSV'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = locations[:games]
    @teams = locations[:teams]
    @game_teams = locations[:game_teams]

  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def game_stats
    game_data = CSV.read(@games, {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
    hashed_game_data = game_data.map { |row| row.to_hash }
    hashed_game_data.each do |row|
      row.delete(:venue)
      row.delete(:venue_link)
    end
  end

  def game_teams_stats
    game_teams_data = CSV.read(@game_teams, {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
    hashed_game_teams_data = game_teams_data.map { |row| row.to_hash }
    hashed_game_teams_data.each do |row|
      row.delete(:pim)
      row.delete(:powerPlayOpportunities)
      row.delete(:powerPlayGoals)
      row.delete(:faceOffWinPercentage)
      row.delete(:giveaways)
      row.delete(:takeaways)
    end
  end

  def teams_stats
    game_teams_data = CSV.read(@teams, {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
    hashed_teams_data = game_teams_data.map { |row| row.to_hash }
    hashed_teams_data.each do |row|
      row.delete(:staduim)
    end
  end
end
