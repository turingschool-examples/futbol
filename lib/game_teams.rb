require 'CSV'

class GameTeam

  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :power_play_opportunities,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways

  # def self.from_csv(data)
  #   GameTeam.new(data)
  # end

  def initialize(data)
    @game_id = data[0]
    @team_id = data[1]
    @hoa = data[2]
    @result = data[3]
    @settled_in = data[4]
    @head_coach = data[5]
    @goals = data[6]
    @shots = data[7]
    @tackles = data[8]
    @pim = data[9]
    @power_play_opportunities = data[10]
    @power_play_goals = data[11]
    @face_off_win_percentage = data[12]
    @giveaways = data[13]
    @takeaways = data[14]
  end

end
