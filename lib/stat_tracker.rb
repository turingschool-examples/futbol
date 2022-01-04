
class StatTracker
  attr_reader :games, :teams, :game_teams, :home_goals, :away_goals, :season

  def initialize(locations)
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    @home_goals = []
    @away_goals = []
    @season = []
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    game_with_max = @games.max_by do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    return game_with_max[:away_goals].to_i + game_with_max[:home_goals].to_i
  end

  def lowest_total_score
    game_with_min = @games.min_by do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    return game_with_min[:away_goals].to_i + game_with_min[:home_goals].to_i
  end

  def tie
    @games.find_all do |game|
      game[:home_goals] == game[:away_goals]
    end
  end

  def percentage_ties
    (tie.count.to_f / games.count * 100).round(3)
  end

end
