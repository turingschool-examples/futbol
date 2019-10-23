require 'csv'

class GameTeams
  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim,
              :powerPlayOpportunities, :powerPlayGoals, :faceOffWinPercentage, :giveaways, :takeaways

  def initialize(game_id, team_id, hoa, result, settled_in, head_coach, goals, shots, tackles, pim,
                  powerPlayOpportunities, powerPlayGoals, faceOffWinPercentage, giveaways, takeaways)
    @game_id = game_id
    @team_id = team_id
    @hoa = hoa
    @result = result
    @settled_in = settled_in
    @head_coach = head_coach
    @goals = goals
    @shots = shots
    @tackles = tackles
    @pim = pim
    @powerPlayOpportunities = powerPlayOpportunities
    @powerPlayGoals = powerPlayGoals
    @faceOffWinPercentage = faceOffWinPercentage
    @giveaways = giveaways
    @takeaways = takeaways
  end

  def self.create(file_path)
    @game_teams = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @game_teams << self.new(row[:game_id],
                                    row[:team_id],
                                    row[:HoA],
                                    row[:result],
                                    row[:settled_in],
                                    row[:head_coach],
                                    row[:goals],
                                    row[:shots],
                                    row[:tackles],
                                    row[:pim],
                                    row[:powerPlayOpportunities],
                                    row[:powerPlayGoals],
                                    row[:faceOffWinPercentage],
                                    row[:giveaways],
                                    row[:takeaways],)
    end
    @game_teams
  end

end
