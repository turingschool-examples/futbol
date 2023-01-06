require 'csv'

class Game_teams
  attr_reader :info
  #  :game_id,
              # :team_id,
              # :hoa,
              # :result,
              # :settled_in,
              # :head_coach,
              # :goals,
              # :shots,
              # :tackles,
              # :pim,
              # :powerPlayOpportunities,
              # :powerPlayGoals,
              # :faceOffWinPercentage,
              # :giveaways,
              # :takeaways
  def initialize(data)
    @info = {
      game_id: data[:game_id],
      team_id: data[:team_id],
      hoa: data[:hoa],
      result: data[:result],
      settled_in: data[:settled_in],
      head_coach: data[:head_coach],
      goals: data[:goals],
      shots: data[:shots],
      tackles: data[:tackets],
      pim: data[:pim],
      powerPlayOpportunities: data[:powerPlayOpportunities],
      powerPlayGoals: data[:powerPlayGoals],
      faceOffWinPercentage: data[:faceOffWinPercentage],
      giveaways: data[:giveaways],
      takeaways: data[:takeaways] }


  end

  def self.create_game_teams(game_teams_data)
    game_teams = []
    CSV.foreach game_teams_data, headers: true, header_converters: :symbol do |row|
      game_teams << Game_teams.new(row)
    end
    game_teams
  end
end