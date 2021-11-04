class Team
  attr_reader :team_id,
              :franchiseId,
              :teamName,
              :abbreviation,
              :stadium,
              :link
  def initialize(info_hash)
    @team_id = info_hash[:team_id].to_i
    @franchiseId = info_hash[:franchiseId].to_i
    @teamName = info_hash[:teamName]
    @abbreviation = info_hash[:abbreviation]
    @stadium = info_hash[:stadium]
    @link = info_hash[:link]
  end
end
