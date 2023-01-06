require 'csv'

class Game_teams
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
  def initialize(info)
    @game_id = info[:game_id]
    @team_id = info[:team_id]
    @hoa = info[:hoa]
    @result = info[:result]
    @settled_in = info[:settled_in]
    @head_coach = info[:head_coach]
    @goals = info[:goals]
    @shots = info[:shots]
    @tackles = info[:tackets]
    @pim = info[:pim]
    @powerPlayOpportunities = info[:powerPlayOpportunities]
    @powerPlayGoals = info[:powerPlayGoals]
    @faceOffWinPercentage = info[:faceOffWinPercentage]
    @giveaways = info[:giveaways]
    @takeaways = info[:takeaways]
  end

  def self.create_game_teams(game_teams_data)
    game_teams = []
    CSV.foreach game_teams_data, headers: true, header_converters: :symbol do |row|
      game_teams << Game_teams.new(row)
    end
    game_teams
  end
end