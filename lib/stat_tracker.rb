require 'csv'
require './lib/teams'

class StatTracker
 attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    StatTracker.new(
    CSV.read(locations[:games], headers: true, header_converters: :symbol),
    CSV.read(locations[:teams], headers: true, header_converters: :symbol),
    CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  )
  end

  def team_info(search_team_id)
    team_search_info = @teams.find do |team|
      team[0] == search_team_id
    end

    {
      "team_id" => team_search_info[0],
      "franchise_id" => team_search_info[1],
      "team_name" => team_search_info[2],
      "abbreviation" => team_search_info[3],
      "link" => team_search_info[5]
    }
  end

  def best_season(search_team_id)
    ##search input##
    game_info = @game_teams.select do |game_team|
      game_team[1] = search_team_id
    end
    ## groups all games into one season
    games_id_season = @games[:season].zip(@games[:game_id])
    games_id_season_h = Hash.new{|hash, key| hash[key] = []}
    games_id_season.each do |season, game|
      games_id_season_h[season] << game
    end
    ## finds all the winning games
    all_win_info = []

    @game_teams.each do |game_team|
      if game_team[:result] == "WIN" && game_team[:team_id] == search_team_id
      all_win_info << game_team[:game_id]
      end
      require "pry"; binding.pry
    end
    ## takeing 1 win from the list of wins
    # season_won = []
    # if all_win_info.each do |game_won|
    #   @games.each do |game|
    #     require "pry"; binding.pry
    #     game[:game_id].include?(game_won) ##should be false.. but when true.. print season
    #     end
    #   end
    # end
  end






end
