class GameManager
  attr_reader :games, :tracker #do we need attr_reader?

  def initialize(path, tracker)
    @games = []
    @tracker = tracker
    create_games(path)
  end

  def create_games(path)
    games_data = CSV.read(path, headers:true) #may need to change .read to .load

    @games = games_data.map do |data|
      Game.new(data, self)
    end
  end

  #------------SeasonStats

  def game_team_results_by_season(season)
require "pry"; binding.pry
    game_ids_in_season = games_of_season.map do |game|
      game['game_id']
    end
    # games_results_per_season = game_teams.find_all do |team_result|
    #   game_ids_in_season.include? team_result['game_id']
    # end
    # games_results_per_season
  end

  def games_of_season(season)
    @games.find_all {|game| game.season == season}
  end
end
