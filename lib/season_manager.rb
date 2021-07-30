require_relative './game'
require_relative './game_team'
require_relative './team'


class SeasonManager
  def initialize(hash)
    @seasons = hash
  end

  def game_id_by_season
    @seasons.transform_values do |games|
      games.map do |game|
        game.game_id
      end
    end
  end
end
