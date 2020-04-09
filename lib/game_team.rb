class GameTeam

  attr_reader :game_id, :team_id, :home_or_away, :result,
              :settled_in, :head_coach, :goals, :shots, :tackles,
              :pim, :power_play_opportunities, :power_play_goals,
              :face_off_win_percentage, :give_aways, :takeaways
  def initialize(csv_row)
    @game_id = csv_row[:game_id]
    @team_id = csv_row[:team_id]
    @home_or_away = csv_row[:hoa]
    @result = csv_row[:result]
    @settled_in = csv_row[:settled_in]
    @head_coach = csv_row[:head_coach]
    @goals = csv_row[:goals].to_i
    @shots = csv_row[:shots].to_i
    @tackles = csv_row[:tackles].to_i
    @pim = csv_row[:pim].to_i
    @power_play_opportunities = csv_row[:powerplayopportunities].to_i
    @power_play_goals = csv_row[:powerplaygoals].to_i
    @face_off_win_percentage = csv_row[:faceoffwinpercentage].to_f
    @give_aways = csv_row[:giveaways].to_i
    @takeaways = csv_row[:takeaways].to_i
  end

end
