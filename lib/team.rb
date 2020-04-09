class Team

  def initialize(data)
    @id = data[:team_id]
    @franchise_id = data[:franchiseid]
    @name = data[:franchiseid]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end
end
