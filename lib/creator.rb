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
  end


end
