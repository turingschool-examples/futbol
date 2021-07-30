require './lib/season'
class SeasonManager

  attr_reader :seasons_hash

  def initialize(seasons, games, game_teams)
    @seasons_hash = {}
    create_seasons(seasons, games, game_teams)
  end

  def create_seasons(seasons, games, game_teams)
    fill_season_ids(seasons)
    @seasons_hash.each do |season_id, season|
      games.each do |game_id, game|
        if game.season == season_id
          @seasons_hash[season_id].add_game(game_id, game, game_teams[game_id][:home], game_teams[game_id][:away])
        end
      end
    end

    require "pry"; binding.pry
  end

  def fill_season_ids(seasons)
    seasons.each do |season|
      @seasons_hash[season] ||= Season.new
    end
  end
end



# def create_seasons(seasons, games, game_teams)
#   fill_season_ids(seasons)
#   @seasons_hash.each do |season_id, data|
#     variable = nil
#     games.each do |game_id, game|
#       if game.season == season_id
#           @seasons_hash[season] ||= Season.new
#       variable = {game_id => game, game_teams[game_id]} #class method containing this data goes here
#     end
#   end
#
#   end

# @seasons_hash[season] = Season.new
