class Team
  attr_reader :team_id, 
              :franchise_id, 
              :team_name, 
              :abbreviation, 
              :stadium, 
              :link

  def initialize(row)
    # require 'pry';binding.pry
    @team_id = row[:team_id]
    @franchise_id = row[:franchiseid]
    @team_name = row[:teamname]
    @abbreviation = row[:abbreviation]
    @stadium = row[:stadium]
    @link = row[:link]
  end
end