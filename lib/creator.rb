require './tg_stat'
class Creator
  attr_reader :league

  def initialize(league)
    @league = league
  end

  def self.create_objects(game_data, team_data, game_team_data)
    # stat_objects = stat_obj_creator(game_team_data)
    league = "this is league"
    self.new(league)
  end

  def stat_obj_creator(game_team_data)
    stats_hash = {}
    game_team_data.each do |stat|
      stat_name = "#{stat[:game_id] + '_' + stat[:team_id]}"
      stats_hash[stat_name] = TGStat.new(stat)
    end
    stats_hash
  end
end
