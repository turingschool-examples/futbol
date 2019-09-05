class Team

  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link,
              :games

  def initialize(team_hash)
    @team_id = team_hash[:team_id]
    @franchise_id = team_hash[:franchiseId]
    @team_name = team_hash[:teamName]
    @abbreviation = team_hash[:abbreviation]
    @stadium = team_hash[:Stadium]
    @link = team_hash[:link]
    @games = team_hash[:games]
  end

end
