class GameTeam
  attr_reader :data

  def initialize(stats)
    @data = {
      :game_id => stats[0].to_i,
      :team_id => stats[1].to_i,
      :hoa => stats[2],
      :result => stats[3],
      :settled_in => stats[4],
      :head_coach => stats[5],
      :goals => stats[6].to_i,
      :shots => stats[7].to_i,
      :tackles => stats[8].to_i,
      :pim => stats[9].to_i,
      :powerplay_opportunities => stats[10].to_i,
      :powerplay_goals => stats[11].to_i,
      :faceoff_win_percentage => stats[12].to_f,
      :giveaways => stats[13].to_i,
      :takeaways => stats[14].to_i
    }
  end
end
