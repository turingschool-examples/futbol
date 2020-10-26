require_relative './team'
require 'CSV'

class TeamsCollection
  attr_reader :teams
  def initialize(file_path)
    @teams = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      team_id = row[:team_id]
      franchiseid = row[:franchiseid]
      teamname = row[:teamname]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]
      @teams << Team.new(team_id,franchiseid,teamname,abbreviation,stadium,link)
    end
  end
end
