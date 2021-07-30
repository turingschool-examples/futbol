class GameTeams
  attr_reader :game_id, :team_id, :home_away, :result, :coach, :goals, :shots, :tackles

  def initialize(game_teams_data)
      @game_id = game_teams_data["game_id"]
      @team_id = game_teams_data["team_id"]
      @home_away = game_teams_data["HoA"]
      @result = game_teams_data["result"]
      @coach = game_teams_data["head_coach"]
      @goals = game_teams_data["goals"].to_i
      @shots = game_teams_data["shots"].to_i
      @tackles = game_teams_data["tackles"].to_i
  end

  def won?
    @result == "WIN"
  end

  def season
    next_year = @game_id[0..3].to_i + 1
    "#{@game_id[0..3]}#{next_year}"
  end
end
