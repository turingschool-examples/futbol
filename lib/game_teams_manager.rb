require 'csv'

class GameTeamsManager
  attr_reader :game_teams_data,
              :game_teams

  def initialize(file_locations)
    @game_teams_data = file_locations[:game_teams]
    @game_teams = []
  end

  def all
    CSV.foreach(@game_teams_data, headers: true, header_converters: :symbol) do |row|
        game_team_attributes = {
                          game_id: row[:game_id],
                          team_id: row[:team_id],
                          HoA:     row[:HoA],
                          result:  row[:result],
                          settled_in: row[:settled_in],
                          head_coach: row[:head_coach],
                          goals:      row[:goals],
                          shots:      row[:shots],
                          tackles:    row[:tackles],
                          pim:        row[:pim],
                          powerPlayOpportunities: row[:powerPlayOpportunities],
                          powerPlayGoals:         row[:powerPlayGoals],
                          faceOffWinPercentage:   row[:faceOffWinPercentage],
                          giveaways: row[:giveaways],
                          takeaways: row[:takeaways]
                        }
      @game_teams << GameTeam.new(game_team_attributes)
    end
    @game_teams
  end
end
