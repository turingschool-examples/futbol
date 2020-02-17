class StatTracker
  def initialize()

  end

  def self.from_csv(locations)
    games_collection = GamesCollection.new
    teams_collection = TeamsCollection.new
    options = {
                  headers: true,
                  header_converters: :symbol,
                  converters: :all
                  }

    CSV.foreach(locations[:games], options) { |row| games_collection.add_game(Game.new(row.to_hash)) }
    CSV.foreach(locations[:teams], options) { |row| teams_collection.add_team(Team.new(row.to_hash)) }
    binding.pry

    # for each row in games csv create game object and put into collection of games
    StatTracker.new()
  end
end
