class GameTeam
  attr_reader :game_id,
              :team_id,
              :home_or_away,
              :game_result,
              :reg_or_ot,
              :coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :power_play_opp,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways

  def initialize(data)
    @game_id = data[:game_id]
    @team_id = data[:team_id]
    @home_or_away = data[:hoa]
    @game_result = data[:result]
    @reg_or_ot = data[:settled_in]
    @coach = data[:head_coach]
    @goals = data[:goals]
    @shots = data[:shots]
    @tackles = data[:tackles]
    @pim = data[:pim]
    @power_play_opp = data[:powerplayopportunities]
    @power_play_goals = data[:powerplaygoals]
    @face_off_win_percentage = data[:faceoffwinpercentage]
    @giveaways = data[:giveaways]
    @takeaways = data[:takeaways]
  end
end
