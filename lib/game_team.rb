class GameTeam
  attr_reader :game_id,
              :team_id,
              :hOa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :powerPlayOpportunities,
              :powerPlayGoals,
              :faceOffWinPercentage,
              :giveaways,
              :takeaways

  def initialize(line)
    array = line.split(',')

    @game_id = array[0].to_i
    @team_id = array[1].to_i
    @hOa = array[2]
    @result = array[3]
    @settled_in = array[4]
    @head_coach = array[5]
    @goals = array[6].to_i
    @shots = array[7].to_i
    @tackles = array[8].to_i
    @pim = array[9].to_i
    @power_play_opportunities = array[10].to_i
    @power_play_goals = array[11].to_i
    @face_off_win_percentage = array[12].to_f
    @giveaways = array[13].to_i
    @takeaways = array[14].to_i
  end
end
