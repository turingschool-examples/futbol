class GameTeams
  attr_reader :game_id,
              :team_id,
              # :HoA,
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
  #             :powerPlayOpportunities,
  #             :powerPlayGoals,
  #             :faceOffWinPercentage,
  #             :giveaways,
  #             :takeaways,
  #             :game_team_manager
  def initialize(row)
    # @game_team_manager = game_team_manager
    @game_id = row[:game_id]
    @team_id = row[:team_id]
    @hoa = row[:HoA]
    @result = row[:result]
    @settled_in = row[:settled_in]
    @head_coach = row[:head_coach]
    @goals = row[:goals].to_i
    @shots = row[:shots].to_i
    @tackles = row[:tackles].to_i
    @pim = row[:pim].to_i
    @power_play_opportunities = row[:powerPlayOpportunities].to_i
    @power_play_goals = row[:powerPlayGoals].to_i
    @face_off_win_percentage = row[:faceOffWinPercentage].to_f
    @giveaways = row[:giveaways].to_i
    @takeaways = row[:takeaways].to_i
    # row.each do |k, v|
    #   instance_variable_set("@#{k}" , v)
    # end
    # @faceOffWinPercentage = @faceOffWinPercentage.to_f
    # @giveaways = @giveaways.to_i
    # @goals = @goals.to_i
    # @pim = @pim.to_i
    # @powerPlayOpportunities = @powerPlayOpportunities.to_i
    # @powerPlayGoals = @powerPlayGoals.to_i
    # @shots = @shots.to_i
    # @tackles = @tackles.to_i
    # @takeaways = @takeaways.to_i

  end

  def game_team_info
    {
      game_id: game_id,
      team_id: team_id,
      # hoa: @HoA,
      hoa: hoa,
      result: result,
      head_coach: head_coach,
      goals: goals
    }
  end
end
