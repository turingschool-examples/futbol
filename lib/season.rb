class Season
  attr_reader :id, :teams
  
  def initialize(season_hash)
    @id = season_hash[:season_id]
    @teams = season_hash[:teams]
  end

end