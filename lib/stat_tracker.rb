require "CSV"
require "./lib/games"
require "./lib/teams"
require "./lib/game_teams"
require "./lib/teams"
# require_relative "./games"
# require_relative "./game_teams"
# require_relative "./teams"

class StatTracker
  attr_reader :games, :game_teams, :teams

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games ||= turn_games_csv_data_into_games_objects(locations[:games])
    @teams ||= turn_teams_csv_data_into_teams_objects(locations[:teams])
    @game_teams ||= turn_game_teams_csv_data_into_game_teams_objects(locations[:game_teams])
  end

  def turn_games_csv_data_into_games_objects(games_csv_data)
    games_objects_collection = []
    CSV.foreach(games_csv_data, headers: true, header_converters: :symbol) do |row|
      games_objects_collection << Games.new(row)
    end
    games_objects_collection
  end

  def turn_teams_csv_data_into_teams_objects(teams_csv_data)
    teams_objects_collection = []
    CSV.foreach(teams_csv_data, headers: true, header_converters: :symbol) do |row|
      teams_objects_collection << Teams.new(row)
    end
    teams_objects_collection
  end

  def turn_game_teams_csv_data_into_game_teams_objects(game_teams_csv_data)
    game_teams_objects_collection = []
    CSV.foreach(game_teams_csv_data, headers: true, header_converters: :symbol) do |row|
      game_teams_objects_collection << GameTeams.new(row)
    end
    game_teams_objects_collection
  end


  def highest_total_score
  output = @games.max_by do |game|
    game.away_goals + game.home_goals
  end
  output.away_goals + output.home_goals
end

#   def total_games
#     games = []
#     @game_teams.map do |game|
#       games << game.result
#     end
#   end

  def lowest_total_score
    output = @games.min_by do |game|
      #game.total_game_score
      game.away_goals + game.home_goals
    end
    output.away_goals + output.home_goals
  end

  def total_number_games_across_seasons
    @games.count
  end


  def percentage_home_wins
    total_home_wins = @games.select do |game|
      game.home_goals > game.away_goals
    end
    (total_home_wins.length.to_f / @games.length).round(2)
  end

  def average_goals_per_game
    games_count = @games.count.to_f
    sum_of_goals = (@games.map {|game| game.total_game_score}.to_a).sum

    sum_of_goals_divided_by_game_count = (sum_of_goals / games_count).round(2)
    sum_of_goals_divided_by_game_count
  end


  def average_goals_by_season
    games_by_season = @games.group_by {|game| game.season} ##hash of games by season
    games_by_season.delete_if { |key, value| key.nil? || value.nil? }

    goals_per_season = {} ##hash of total goals by season
    games_by_season.map do |season, games|
      goals_per_season[season] = games.sum do |game|
        game.away_goals + game.home_goals
      end
    end

    avg_goals_per_season = {}
    goals_per_season.each do |season, goals|
      division = (goals.to_f / count_of_games_by_season[season] ).round(2)
      avg_goals_per_season[season] = division
    end
    avg_goals_per_season
  end


  def percentage_visitor_wins
    total_visitor_wins = @games.select do |game|
      game.away_goals > game.home_goals
    end
    (total_visitor_wins.length.to_f / @games.length).round(2)
  end

   def percentage_tie
    game_ties = @game_teams.select do |game|
      game.result == "TIE"
    end
    (game_ties.count / @game_teams.count.to_f).round(2)
  end

   def count_of_games_by_season
    games_by_season = @games.group_by {|game| game.season}
    game_count_per_season = {}
    games_by_season.map {|season, game| game_count_per_season[season] = game.count}
    game_count_per_season
  end

  def count_of_teams
    @number_of_teams = []
    @games.each do |game|
      @number_of_teams << game.home_team_id
    end
    @number_of_teams = @number_of_teams.uniq
    @number_of_teams.count
  end

  def highest_scoring_visitor
    best_team = overall_average_scores_by_away_team.max_by do |team_id, average_goals_per_game|
      average_goals_per_game
    end
    @teams.find do |team|
      team.team_id == best_team[0]
    end.teamname
  end


  def highest_scoring_home_team
      home_team = @games.group_by do |game|
        game.home_team_id
      end
      goals = {}
      home_team.each do |team_id, games|
        goal_count = 0
        games.each do |game|
            goal_count += game.home_goals
          end
          average_goals = goal_count / games.count.to_f
          goals[team_id] = average_goals
        end
        id = goals.max_by {|key, value| value}
        @teams.find {|team| team.team_id == id[0]}.teamname
    end

    def most_tackles(season)
        season_hash = @games.group_by {|games| games.season}
        season_hash.delete_if {|k, v| k.nil?}

        game_ids_by_season = {}
          season_hash.map do |season, games|
            game_ids_by_season[season] = games.map {|game| game.game_id}
          end


        games_by_season = {}
        game_ids_by_season.map do |season, game_ids|
          season_games = @game_teams.map do |game|
            if game_ids.include?(game.game_id)
              game
            end
          end
          games_by_season[season] = season_games
        end

      season_games = games_by_season.map {|season, games| games}.flatten.compact

      new_hash = Hash.new([])
      game_ids_by_season.each do |k, v|
        v.each do |game|
        new_hash[k] += season_games.select {|season_game| season_game.game_id == game}
        end
      end

      team_tackles = Hash.new(0)
        new_hash[season].each do |game|
          team_tackles[game.team_id] += game.tackles
        end
      team_tackles.delete_if {|k, v| k.nil?}

      most = team_tackles.max_by {|k, v| v}
      @teams.find {|team| team.team_id == most.first}.teamname
      #binding.pry

      # id = goals.max_by {|key, value| value}
      # @teams.find {|team| team.team_id == id[0]}.teamname
    end#tackle method
end
