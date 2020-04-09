class GameTeam

  attr_reader :game_id, :team_id, :home_or_away, :result,
              :settled_in, :head_coach, :goals, :shots, :tackles,
              :pim, :power_play_opportunities, :power_play_goals,
              :face_off_win_percentage, :give_aways, :takeaways
  def initialize(csv_row)
    @game_id = csv_row[:game_id]
    @team_id = csv_row[:team_id]
    @home_or_away = csv_row[:HoA]
    @result = csv_row[:result]
    @settled_in = csv_row[:settled_in]
    @head_coach = csv_row[:head_coach]
    @goals = csv_row[:goals]
    @shots = csv_row[:shots]
    @tackles = csv_row[:tackles]
    @pim = csv_row[:pim]
    @power_play_opportunities = csv_row[:powerPlayOpportunities]
    @power_play_goals = csv_row[:powerPlayGoals]
    @face_off_win_percentage = csv_row[:faceOffWinPercentage]
    @give_aways = csv_row[:give_aways]
    @takeaways = csv_row[:takeaways]
  end

end
