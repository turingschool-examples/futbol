class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link

  def initialize(info)
    @team_id = info['team_id']
    @franchise_id = info['franchiseId']
    @team_name = info['teamName']
    @abbreviation = info['abbreviation']
    @stadium = info['Stadium']
    @link = info['link']
  end

  def self.create_list_of_teams(teams)
    teams.map { |team| Team.new(team) }
  end
end
