require './tg_stat'
require './game'

class Creator
  attr_reader :league

  def initialize(league)
    @league = league
  end

  def self.create_objects(game_data, team_data, game_team_data)
    stats_hash = self.stat_obj_creator(game_team_data)
    games_hash = self.game_obj_creator(game_data, stats_hash)


    league = "this is league"
    self.new(league)
  end

  def self.stat_obj_creator(game_team_data)
    stats_hash = {}
    game_team_data.each do |stat|
      stat_name = "#{stat[:game_id] + '_' + stat[:team_id]}"
      stats_hash[stat_name] = TGStat.new(stat)
    end
    stats_hash
  end

  def self.game_obj_creator(game_data, stats_hash)
    games_hash = {}
    game_data.each do |game|
      home_team = "#{game[:game_id] + '_' + game[:home_team_id]}"
      away_team = "#{game[:game_id] + '_' + game[:away_team_id]}"
      # require 'pry'; binding.pry
      games_hash[game[:game_id]] = Game.new(game, stats_hash[home_team], stats_hash[away_team])
    end
    games_hash
  end

  def self.season_obj_creator(games_hash)
    seasons_hash = games_hash.values.group_by do |game|
      game.season
    end
  end

  def team_obj_creator
  end

  def league_obj_creator
  end

end
