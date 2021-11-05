
class GameTeam

  attr_reader :game_id, :team_id, :HoA, :result, :settled_in,
  :head_coach, :goals, :shots, :tackles, :pim,
  :powerPlayOpportunities, :powerPlayGoals, :faceOffWinPercentage,
  :giveaways, :takeaways

  def initialize(row)
    # take all the csv headers and turn them to instance variables/ attr readers
    # and call the keys as strings on the row hash argument
    # determine what TYPE each instance variable is
    @game_id = row['game_id'].to_i
    @team_id = row['team_id'].to_i
    @HoA = row['HoA']
    @result = row['result']
    @settled_in = row['settled_in']
    @head_coach = row['head_coach']
    @goals = row['goals'].to_i
    @shots = row['shots'].to_i
    @tackles = row['tackles']
    @pim = row['pim'].to_i
    @powerPlayOpportunities = row['powerPlayOpportunities'].to_i
    @powerPlayGoals = row['powerPlayGoals'].to_i
    @faceOffWinPercentage = row['faceOffWinPercentage'].to_f
    @giveaways = row['giveaways'].to_i
    @takeaways = row['takeaways'].to_i
  end

end
