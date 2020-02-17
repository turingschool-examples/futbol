require 'csv'

class StatTracker
  attr_accessor :game_path, :team_path, :game_teams_path

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_path = locations[:games]
    @team_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
  end

  def percentage_home_wins
    home_wins = 0
    home_losses = 0
    CSV.foreach(@game_teams_path, headers: true, header_converters: :symbol) do |row|
      if row[:hoa] == "home" && row[:result] == "WIN"
        home_wins += 1
      elsif row[:hoa] == "home" && row[:result] == "LOSS"
        home_losses += 1
      end
    end
    (100 * home_wins.fdiv(home_wins + home_losses)).round(2)
  end

  def percentage_ties
    ties = 0
    not_ties = 0
    CSV.foreach(@game_path, headers: true, header_converters: :symbol) do |row|
      if row[:away_goals] == row[:home_goals]
        ties += 1
      else
        not_ties += 1
      end
    end
    (100 * ties.fdiv(ties + not_ties)).round(2)
  end
end
