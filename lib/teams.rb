class Team
  attr_reader :game_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(attributes)
    @game_id      = attributes[:game_id]
    @franchise_id = attributes[:franchiseid]
    @team_name    = attributes[:teamname]
    @abbreviation = attributes[:abbreviation]
    @stadium      = attributes[:stadium]
    @link         = attributes[:link]
  end
end