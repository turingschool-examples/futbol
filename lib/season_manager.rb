class SeasonManager
  attr_reader :seasons_hash
  def initialize(seasons, games, game_teams)
    @seasons_hash = {}
    create_seasons(seasons, games, game_teams)
  end

  def create_seasons(seasons, games, game_teams)
    fill_season_ids(seasons)
    games.each do |game_id, game|
      Season.new  = @seasons_hash.each do |season, game_id2|
        if game.season == season
          @seasons_hash[season] == Season.new()
          @seasons_hash[season][game_id] = [game, game_teams[game_id]]
        end
      end
    end
  end

  def fill_season_ids(seasons)
    seasons.each do |season|
      @seasons_hash[season] ||= {}

    end
  end
end
