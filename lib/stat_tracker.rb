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


  def lowest_total_score
    scores = @games.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    scores.min
  end

  def percentage_home_wins
    (total_home_wins.to_f / total_games.to_f).round(2)
  end

  def percentage_visitor_wins
    (total_away_wins.to_f / total_games.to_f).round(2)
  end

  def total_games
    @games.count
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

  def total_home_losses
    home_losses = 0
    @games.each do |row|
      if row[:away_goals] >= row[:home_goals]
        home_losses += 1
      end
    end
    home_losses
  end

  def total_ties
    total_ties = 0
    @games.each do |row|
      if row[:away_goals] == row[:home_goals]
        total_ties += 1
      end
    end
    total_ties
  end

  def total_away_losses
    total_home_wins
  end

  def total_away_wins
    total_home_losses
  end

end
