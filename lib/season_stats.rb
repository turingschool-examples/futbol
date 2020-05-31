class SeasonStats
  attr_reader :game_collection,
              :game_team_collection,
              :team_collection

  def initialize(game_collection, game_team_collection, team_collection)
    @game_collection = game_collection
    @game_team_collection = game_team_collection
    @team_collection = team_collection
  end

  # def winningest_coach(season_id)
  #
  #   # go into games_fixture file and look at a single
  #   # season's game_ids
  #   # coach has most wins for a season
  # end

  # def games_per_season(season_id)
  #   @game_collection.games_array.find_all do |game|
  #     game.season == season_id
  #   end
  # end

  def total_games(head_coach)
    @game_team_collection.game_teams_array.count do |game_team|
      game_team.head_coach == head_coach
    end
  end

  def total_wins(head_coach)

  end

  # def win_percentage(head_coach)
  #   total_games =
  #
  #   |game|
  #   game.result == "WIN"
  # wins  / total games
  # end

  # an array of games from a specific season
  # for a coach, how many wins out of total games played



end
