

class GameTeam
  attr_reader(
    :game_id,
    :team_id,
    :HoA,
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
  )

  def initialize(row)
    @game_id = row[0]
    @team_id = row[1]
    @HoA = row[2]
    @result = row[3]
    @settled_in = row[4]
    @head_coach = row[5]
    @goals = row[6]
    @shots = row[7]
    @tackles = row[8]
    @pim = row[9]
    @powerPlayOpportunities = row[10]
    @powerPlayGoals = row[11]
    @faceOffWinPercentage = row[12]
    @giveaways = row[13]
    @takeaways = row[14]
  end

end
