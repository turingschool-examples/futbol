class SeasonCollection
  attr_reader :seasons

  def initialize(filepath, season_ids, team_ids, parent)
    @parent     = parent
    @team_ids   = team_ids
    @season_ids = season_ids
    @seasons    = [] 
    create_seasons(filepath)
  end

  def seasons_by_team(filepath)
    @seasons_by_team = map_seasons_by_team
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      season = find_season_id(row[:game_id])
      @seasons_by_team[row[:team_id]][season] << row.to_h
    end
  end

  def create_seasons(filepath)
    @seasons_by_team.each do |team_id, seasons|
      seasons.each do |season_id, games_teams|
        @seasons << Season.new(team_id, season_id, games_teams, self)
      end
    end 
  end

  def find_season_id(game_id)
    @parent.find_season_id(game_id)
  end

  def map_seasons_by_team
      @team_ids.each_with_object({}) do |team_id, teams_hash|
        teams_hash[team_id] = @season_ids.each_with_object({}) do |season, seasons_hash|
          seasons_hash[season] = []
        end
      end  
  end
end
