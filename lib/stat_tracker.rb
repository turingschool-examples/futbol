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
    game_info = @game_teams.find do |game|
      game[1] = search_team_id
    end
    # require "pry"; binding.pry
    all_lost_info = []

    @game_teams.each do |per_line|
    if per_line[3] == "LOSS"
      all_lost_info << per_line[0]
      end
    end
    all_lost_info
  end



end
