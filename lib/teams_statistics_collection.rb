require "csv"
require_relative "./teams"

class TeamsStatisticsCollection
  attr_reader :csv_location,
              :collection

  def initialize(csv_location)
    @csv_location = csv_location
    @collection = []
  end

  def load_teams
    CSV.foreach(@csv_location, :headers => true, :header_converters => :symbol) do |row|
      team_id = row[:team_id]
      franchiseid = row[:franchiseid]
      teamname = row[:teamname]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]

    @collection << Teams.new({ :team_id => team_id, :franchiseid => franchiseid, :teamname => teamname, :abbreviation => abbreviation, :stadium => stadium, :link => link })
    end
  end
end
