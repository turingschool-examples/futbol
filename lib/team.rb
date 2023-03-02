class Team
  attr_reader :id,
              :franchise_id,
              :name,
              :abbreviation,
              :stadium,
              :link

  def initialize(data)
    @id = data[:team_id]
    @franchise_id = data[:franchiseid]
    @name = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end
end
