class Teams
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link
  def initialize(info_hash)
    @team_id = info_hash[:team_id].to_i
    @franchiseid = info_hash[:franchiseid].to_i
    @teamname = info_hash[:teamname]
    @abbreviation = info_hash[:abbreviation]
    @stadium = info_hash[:stadium]
    @link = info_hash[:link]
  end
end
