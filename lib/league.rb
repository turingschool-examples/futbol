class League
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link
  
  def initialize(locations)
    team_file = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @team_id = team_file[:team_id]
    @franchise_id = team_file[:franchiseId]
    @team_name = team_file[:teamName]
    @abbreviation = team_file[:abbreviation]
    @stadium = team_file[:Stadium]
    @link = team_file[:link]  
  end

  def count_of_teams
    @team_id.count
  end
end