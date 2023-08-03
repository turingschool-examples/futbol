require_relative "helper_class"

class SeasonGameID
  @@games = []
  attr_reader :season, :game_id

  def initialize(data)
    @season = data[:season]
    @game_id = data[:game_id]
    @@games << self
  end

  def self.games
    @@games
  end
end