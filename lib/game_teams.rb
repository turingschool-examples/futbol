class GameTeams
  attr_reader :game_id,
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
              :takeaways,
              :game_team_manager
  def initialize(row)
    row.each do |k, v|
      instance_variable_set("@#{k}" , v)
    end
    @faceOffWinPercentage = @faceOffWinPercentage.to_f
    @giveaways = @giveaways.to_i
    @goals = @goals.to_i
    @pim = @pim.to_i
    @powerPlayOpportunities = @powerPlayOpportunities.to_i
    @powerPlayGoals = @powerPlayGoals.to_i
    @shots = @shots.to_i
    @tackles = @tackles.to_i
    @takeaways = @takeaways.to_i
    @game_team_manager = game_team_manager
  end

  # def team_name
  #   @game_team_manager.team_by_id(team_id)
  # end
end
