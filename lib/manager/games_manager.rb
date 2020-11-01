class GamesManager
  attr_reader :location,
              :parent,
              :games

  def self.get_data(location, parent)
    games = []
    CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
      games << Game.new(row, self)
    end
    new(location, parent, games)
  end

  def initialize(location, parent, games)
    @location = location
    @parent = parent
    @games = games
  end

  def highest_total_score
    games.max_by { |game| game.total_score }.total_score
  end

  #def verify_in_season(season, game_id)
    #verify = false
    #@games.each do |game|
      #return true if game.game_id == game_id && game.season == season
    #end

    #verify
  #end

  def game_ids_by_season(season)
    #games_by_season = games.find_all do |game|
      #game.season == season
    #end
    games_by_season = games_by_season.map! do |game|
      game.game_id if game.season == season
    end
    #require 'pry'; binding.pry
  end
end