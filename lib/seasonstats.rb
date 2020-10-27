require 'csv'

class SeasonStats
  def self.from_csv(locations)
    SeasonStats.new(locations)
  end

  def initialize(locations)
    @locations = locations
    @game_teams_table = CSV.parse(File.read(@locations[:game_teams]), headers: true)
    @games_table = CSV.parse(File.read(@locations[:games]), headers: true)
  end

  def games_per_season
    seasons_and_games = {}
    @games_table.each do |game|
      if !seasons_and_games[game["season"]]
        seasons_and_games[game["season"]] = [game["game_id"]]
      else seasons_and_games[game["season"]] << game["game_id"]
      end
    end
  end

  def winningest_coach(season)
    #hash[20122013] = array of game ids
    #iterate through game ids if needed for wins, etc.
    #highest percentage of wins out of games per season
    #20122013 --- game1, game2, game3
    #who won game 1, who won
  end

end
