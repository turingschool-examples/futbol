class GameTeams
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
              :powerPlayOpportunities,
              :powerPlayGoals,
              :faceOffWinPercentage,
              :giveaways,
              :takeaways

  def initialize(line)
    @game_id = line.split(",")[0].to_i
    @team_id = line.split(",")[1].to_i
    @hoa = line.split(",")[2]
    @result = line.split(",")[3]
    @settled_in = line.split(",")[4]
    @head_coach = line.split(",")[5]
    @goals = line.split(",")[6].to_i
    @shots = line.split(",")[7].to_i
    @tackles = line.split(",")[8].to_i
    @pim = line.split(",")[9].to_i
    @powerPlayOpportunities = line.split(",")[10].to_i
    @powerPlayGoals = line.split(",")[11].to_i
    @faceOffWinPercentage = line.split(",")[12].to_f
    @giveaways = line.split(",")[13].to_i
    @takeaways = line.split(",")[14].to_i
  end

end
