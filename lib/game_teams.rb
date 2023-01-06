require 'csv'

class GameTeams
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
      power_play_opportunities: data[:powerPlayOpportunities],
      power_play_goals: data[:powerPlayGoals],
      face_off_win_percentage: data[:faceOffWinPercentage],
      giveaways: data[:giveaways],
      takeaways: data[:takeaways] }
  end

  def self.create_game_teams(game_teams_data)
    game_teams = []
    CSV.foreach game_teams_data, headers: true, header_converters: :symbol do |row|
      game_teams << GameTeams.new(row)
    end
    game_teams
  end
end