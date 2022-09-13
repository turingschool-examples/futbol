require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    scores = @games.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    scores.max
  end

  def total_games 
    games = []
    @game_teams.each do |row|
      games << row[:game_id]  
    end
    games.uniq.count
  end

  def total_home_wins
    home_wins = 0
    @games.each do |row|
      if row[:home_goals] >= row[:away_goals]
        home_wins += 1
      end
    end
    home_wins
  end


end
