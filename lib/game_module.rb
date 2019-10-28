module GameModule

  def visitor_score_maker #makes a hash that holds the away_team_id with a value of total goals
    @away_goals = Hash.new(0)
    @game_counter_visitor = Hash.new(0)

    @game_instances.each do |game|
      @game_counter_visitor[game.away_team_id] += 1.0
      @away_goals[game.away_team_id] += game.away_goals.to_f
    end
  end

  def home_score_maker
    @home_goals = Hash.new(0)
    @game_counter_home = Hash.new(0)

    @game_instances.each do |game|
      @game_counter_home[game.home_team_id] += 1.0
      @home_goals[game.home_team_id] += game.home_goals.to_f
    end
  end

  def id_goal_counter_away
    @id_identifier = Hash.new(0)
    @away_goals.each do |key, value|
      @id_identifier[key] = (value / @game_counter_visitor[key])
    end
  end

  def id_goal_counter_home
    @id_identifier_home = Hash.new(0)
    @home_goals.each do |key, value|
      @id_identifier_home[key] = (value / @game_counter_home[key])
    end
  end
end
