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
    game_info = @game_teams.find do |game_team|
      game_team[1] = search_team_id
    end

    all_win_info = []
      @game_teams.each do |game_team|
        if game_team[3] == "WIN" && game_team[1] == search_team_id
          all_win_info << game_team[0]
        end
      end
    all_win_info

    season_won = []
    @games.each do |game|
      all_win_info.each do |per_game|
      if per_game == game[0]
        season_won << game[1]
        # require "pry"; binding.pry
        end
      end
    end
    best_season_percentage = (season_won.tally.values.sort.last.to_f / @games.count) * 100
    best_season_percentage.round(2).to_s
  end

  def worst_season(search_team_id)
    ##search input##
    game_info = @game_teams.find do |game_team|
      game_team[1] = search_team_id
    end

    all_win_info = []
      @game_teams.each do |game_team|
        if game_team[3] == "WIN" && game_team[1] == search_team_id
          all_win_info << game_team[0]
        end
      end
    all_win_info

    season_won = []
    @games.each do |game|
      all_win_info.each do |per_game|
      if per_game == game[0]
        season_won << game[1]
        # require "pry"; binding.pry
        end
      end
    end
    best_season_percentage = (season_won.tally.values.sort.first.to_f / @games.count) * 100
    best_season_percentage.round(2).to_s
  end

end
