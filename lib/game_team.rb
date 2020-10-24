class GameTeam
  def initialize(row)
    @team_id = row[1],
    @HoA = row[2],
    @result = row[3],
    @settled_in = row[4],
    @head_coach = row[5],
    @goals = row[6],
    @shots = row[7],
    @tackles = row[8],
    @pim = row[9],
    @powerPlayOpportunities = row[10],
    @powerPlayGoals = row[11],
    @faceOffWinPercentage = row[12],
    @giveaways = row[13],
    @takeaways = row[14]
  end
end
