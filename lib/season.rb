class Season
  attr_reader :season_id,
              :games_in_season

  def initialize(season_id, games_in_season)
    @season_id = season_id
    @games_in_season = games_in_season

  end

  def self.generate_seasons(games)
    seasons_ids = games.map{|game| game.season}.uniq
    seasons_hash = {}
    seasons_ids.each do |season_id|
      games_in_season = games.find_all do |game|
        game.season == season_id
      end
      seasons_hash[season_id] = Season.new(season_id, games_in_season)
    end
    seasons_hash
  end
end
