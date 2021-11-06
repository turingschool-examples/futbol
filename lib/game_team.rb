class GameTeam
  attr_reader :game_id, :team_id, :home_or_away, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim, :power_play_opportunities, :power_play_goals, :face_off_win_percentage, :giveaways, :takeaways
  def initialize(data)
    @game_id = data["game_id"]
    @team_id = data["team_id"]
    @home_or_away = data["HoA"]
    @result = data["result"]
    @settled_in = data["settled_in"]
    @head_coach = data["head_coach"]
    @goals = data["goals"]
    @shots = data["shots"]
    @tackles = data["tackles"]
    @penalty_minutes = data["pim"]
    @power_play_opportunities = data["powerPlayOpportunities"]
    @power_play_goals = data["powerPlayGoals"]
    @face_off_win_percentage = data["faceOffWinPercentage"]
    @giveaways = data["giveaways"]
    @takeaways = data["takeaways"]
  end

  # def highest_total_score
  #   grouped_by_game = @game_teams.group_by do |row|
  #     row["game_id"]
  #   end
  #   game_sum_goals = []
  #   grouped_by_game.each_pair do |key, value|
  #     first_team_goals = value.first["goals"].to_i
  #     second_team_goals = value.last["goals"].to_i
  #     game_sum_goals << first_team_goals + second_team_goals
  #   end
  #   game_sum_goals.max
  # end


end
