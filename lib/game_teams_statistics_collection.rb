require 'csv'
require_relative './game_teams'

class GameTeamsStatisticsCollection
  attr_reader :game_teams_csv_location,
              :collection

  def initialize(game_teams_csv_location)
    @game_teams_csv_location = game_teams_csv_location
    @collection = []
  end

  def load_csv
    CSV.foreach(@game_teams_csv_location, :headers => true, :header_converters => :symbol) do |row|

      game_id = row[:game_id]
      team_id = row[:team_id]
      hoa = row[:hoa]
      result = row[:result]
      settled_in = row[:settled_in]
      head_coach = row[:head_coach]
      goals = row[:goals]
      shots = row[:shots]
      tackles = row[:tackles]
      pim = row[:pim]
      powerplayopportunities = row[:powerplayopportunities]
      powerplaygoals = row[:powerplaygoals]
      faceoffwinpercentage = row[:faceoffwinpercentage]
      giveaways = row[:giveaways]
      takeaways = row[:takeaways]

      @collection << GameTeams.new({
        :game_id => game_id,
        :team_id => team_id,
        :hoa => hoa,
        :result => result,
        :settled_in => settled_in,
        :head_coach => head_coach,
        :goals => goals,
        :shots => shots,
        :tackles => tackles,
        :pim => pim,
        :powerplayopportunities => powerplayopportunities,
        :powerplaygoals => powerplaygoals,
        :faceoffwinpercentage => faceoffwinpercentage,
        :giveaways => giveaways,
        :takeaways => takeaways
        })
    end
  end
end
