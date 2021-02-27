class Team

  attr_reader :team_id,
              :franchiseId,
              :teamName,
              :abbreviation,
              :Stadium,
              :link

  def initialize(data, parent)
    @team_id = data[:team_id]
    @franchiseId = data[:franchiseid]
    @team_name = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
    @parent = parent
  end

end
