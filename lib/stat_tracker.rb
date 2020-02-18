class StatTracker
  def initialize(stat_collections)
    @games_collection = stat_collections[:games]
    @teams_collection = stat_collections[:teams]
    @game_teams_collection = stat_collections[:game_teams]
  end

  def self.from_csv(locations)
    StatTracker.new({
                    games: StatTracker.fill_collection(locations[:games], GamesCollection, Game),
                    game_teams: StatTracker.fill_collection(locations[:game_teams], GameTeamsCollection, GameTeam),
                    teams: StatTracker.fill_collection(locations[:teams], TeamsCollection, Team),
                    })
  end

  def self.fill_collection(file, collection_class, element_class)
    collection = collection_class.new
    csv_options = {
                    headers: true,
                    header_converters: :symbol,
                    converters: :all
                  }
      CSV.foreach(file, csv_options) { |row| collection.add(element_class.new(row.to_hash)) }
      collection
  end

end
