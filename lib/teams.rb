require 'csv'
require 'pry'

class Team
  attr_reader :team_id, :franchiseId, :teamName, :abbreviation, :stadium, :link

  def initialize(team_id, franchiseId, teamName, abbreviation, stadium, link)
    @team_id = team_id
    @franchiseId = franchiseId
    @teamName = teamName
    @abbreviation = abbreviation
    @stadium = stadium
    @link = link
  end

  def self.create(file_path)
    @teams = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @teams << self.new(row[:team_id],
                                    row[:franchiseid],
                                    row[:teamname],
                                    row[:abbreviation],
                                    row[:stadium],
                                    row[:link])
<<<<<<< Updated upstream
=======
                                    
>>>>>>> Stashed changes
    end
    @teams
  end

end
