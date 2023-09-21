class Team
  @@teams = []
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
    @Stadium = attributes[:Stadium]
    @link = attributes[:link]
    @@teams << self
  end

def self.teams
  @@teams
end