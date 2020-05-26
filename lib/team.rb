class Team

  attr_reader :id,
              :franchise_id,
              :name,
              :abbreviation,
              :stadium,
              :link

  def initialize(info)
    @id           = info[:team_id]
    @franchise_id = info[:franchiseid]
    @name         = info[:teamname]
    @abbreviation = info[:abbreviation]
    @stadium      = info[:stadium]
    @link         = info[:link]
  end
end
