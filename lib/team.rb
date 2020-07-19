class Team
  @@team = []

  attr_reader :team_id, :teamname

  def initialize(info)
    @team_id = info[:team_id]
    @franchiseid = info[:franchiseid]
    @teamname = info[:teamname]
    @abbreviation = info[:abbreviation]
    @link = info[:link]
    @stadium = info[:stadium]
  end

  def self.add(team)
    @@team << team
  end

  def self.all
    @@team
  end
end 
