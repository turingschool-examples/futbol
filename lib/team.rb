

class Team
  attr_reader :team_id,
              :franchise_id,
              :name,
              :abbreviation,
              :stadium
              
  def initialize(data)
    @team_id = data[:team_id]
    @franchise_id = data[:franchiseid]
    @name = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end
end