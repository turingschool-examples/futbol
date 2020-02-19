class Team
  @@teams = {}

  def self.add(team)
    @@teams[team.team_id] = team
  end

  def self.all
    @@teams
  end
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(data)
    @team_id = data[:team_id]
    @franchise_id = data[:franchise_id]
    @team_name = data[:team_name]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end

end
