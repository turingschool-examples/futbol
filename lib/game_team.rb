class GameTeam
  attr_reader :goals, :team_id, :HoA, :result, :shots, :tackles, :head_coach
  def initialize(row)
    @team_id = row[1].to_i
    @HoA = row[2]
    @result = row[3]
    @settled_in = row[4]
    @head_coach = row[5]
    @goals = row[6].to_i
    @shots = row[7].to_i
    @tackles = row[8].to_i
    @pim = row[9].to_i
    @powerPlayOpportunities = row[10].to_i
    @powerPlayGoals = row[11].to_i
    @faceOffWinPercentage = row[12].to_f
    @giveaways = row[13].to_i
    @takeaways = row[14].to_i
  end
end
