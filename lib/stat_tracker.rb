require 'csv'
class StatTracker
  attr_reader :game_teams,
              :game_rows,
              :teams

  def initialize(locations)
    @game_rows = CSV.read locations[:games], headers: true, header_converters: :symbol
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def games
    @games ||= game_rows.map do |row|
      Game.new(row.to_h)
    end
  end
end