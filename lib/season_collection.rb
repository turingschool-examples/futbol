class SeasonCollection
  attr_reader :seasons

  def initialize(filepath, season_ids, team_ids, parent)
    @parent     = parent
    @team_ids   = team_ids
    @season_ids = season_ids
    @seasons    = [] 
    create_seasons(filepath)
  end

  def create_seasons(filepath)
    seasons_by_team = {}
    
    CSV.foreach(file_path, headers: true, header_converters: :symbol)
  end

  def map_seasons_by_team
      @team_ids.each_with_object({}) do |team_id, teams_hash|
        teams_hash[team_id] = @season_ids.each_with_object({}) do |season, seasons_hash|
          seasons_hash[season] = []
        end
      end  
  end

  # def get_first_game
  #   @games_collection.games.first
  # end

  # def games_by_season
  #   @games_collection.count_of_games_by_season
  # end

  # def goals_by_team
  #   wins = Hash.new(0)
  #   games_by_season.each do |game|
  #     wins[game:season] += 1

  # end

  # def winningest_coach
  # end

  # def worst_coach
  # end

end
