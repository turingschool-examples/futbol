require 'csv'
class StatTracker
  attr_reader :game_path,
              :team_path,
              :game_teams_path

  def initialize(locations)
    @game_path = CSV.read(locations[:games], headers: true, skip_blanks: true, header_converters: :symbol)
    @team_path = CSV.read(locations[:teams], headers: true, skip_blanks: true, header_converters: :symbol)
    @game_teams_path = CSV.read(locations[:game_teams], headers: true, skip_blanks: true, header_converters: :symbol)
    
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def all_scores #HELPER for highest_total_score and lowest_total_score
   @game_path.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
  end

  def highest_total_score 
    all_scores.max
  end

  def lowest_total_score 
    all_scores.min
  end

  def home_wins_array #HELPER for percentage_home_wins
    @game_path.find_all do |row|
     row[:home_goals].to_i > row[:away_goals].to_i
    end
  end

  def percentage_home_wins 
    wins = home_wins_array.count
    (wins.to_f / @game_path.count).round(2)
  end
end