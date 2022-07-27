require_relative './stat_tracker'
require 'csv'

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
              :takeaways

  def self.create_multiple_game_teams(location)
    game_teams = CSV.parse(File.read(location), headers: true, header_converters: :symbol).map(&:to_h)
    game_teams_as_objects = game_teams.map { |row| GameTeams.new(row) }
  end

  def initialize(game_team_info)
    @game_id = game_team_info[:game_id]
    @team_id = game_team_info[:team_id]
    @hoa = game_team_info[:hoa]
    @result = game_team_info[:result]
    @settled_in = game_team_info[:settled_in]
    @head_coach = game_team_info[:head_coach]
    @goals = game_team_info[:goals]
    @shots = game_team_info[:shots]
    @tackles = game_team_info[:tackles]
    @pim = game_team_info[:pim]
    @powerPlayOpportunities = game_team_info[:powerPlayOpportunities]
    @powerPlayGoals = game_team_info[:powerPlayGoals]
    @faceOffWinPercentage = game_team_info[:faceOffWinPercentage]
    @giveaways = game_team_info[:giveaways]
    @takeaways = game_team_info[:takeaways]
  end
end
