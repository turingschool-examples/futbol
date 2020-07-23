require_relative './lib/game_data'
require_relative './lib/game_team_data'
require_relative '.lib/team_data'

class StatTracker

  def self.from_csv(data)

    StatTracker.new(data)
  end

  attr_reader :data #For testing. Eventually make a mock/stub so our test can pass without this

  def initialize(data)
    @data = data
  end
end
