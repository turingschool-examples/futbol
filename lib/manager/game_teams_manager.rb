class GameTeamsManager
  attr_reader :location,
              :parent,
              :game_teams

  def self.get_data(location, parent)
    game_teams = []
    CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row, self)
    end

    new(location, parent, game_teams)
  end

  def initialize(location, parent, game_teams)
    @location = location
    @parent = parent
    @game_teams = game_teams
  end
end