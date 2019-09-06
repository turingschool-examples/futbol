class Season
  attr_reader :season_id
  
  def initialize(season_hash)
    @season_id = season_hash[:season]
    @teams = season_hash[:teams]
  end

end