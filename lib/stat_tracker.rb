class StatTracker
  attr_reader :games, :game_teams, :teams
  def self.from_csv(locations)
    new(locations)
  end

  def initialize(locations)
    @games = locations[:games]
    @game_teams = locations[:game_teams]
    @teams = locations[:teams]
  end

  def highest_total_score # Rename later, for now from Games Table
    most = 0
    CSV.foreach(games, :headers => true, header_converters: :symbol) do |row|
      total = row[:away_goals].to_i + row[:home_goals].to_i
      most = total if total > most
    end
    most
  end

  def count_of_teams
    CSV.read(teams, headers: true).count
  end

end
