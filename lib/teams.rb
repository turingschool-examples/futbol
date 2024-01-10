class Teams
  attr_reader :team_id,
              :franchisedId,
              :teamName,
              :abbreviation,
              :Stadium,
              :link

  def initialize(data)
    @team_id = data[:team_id].to_i
    @franchisedId = data[:franchisedId].to_i
    @teamName = data[:teamName]
    @abbreviation = data[:abbreviation]
    @Stadium = data[:Stadium]
    @link = data[:link]
  end
end
