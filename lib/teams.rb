require_relative "./stat_tracker"
require_relative "./stat_helper"
class Teams 

attr_reader :team_id, 
            :franchise_id,
            :team_name,
            :abbreviation,
            :stadium,
            :link
            
  def initialize(row)
    @team_id = row[:team_id]
    @franchise_id = row[:franchiseid]
    @team_name = row[:teamname]
    @abbreviation = row[:abbreviation]
    @stadium = row[:stadium]
    @link = row[:link]
  end
end
