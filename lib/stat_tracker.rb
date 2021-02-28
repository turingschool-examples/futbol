require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative 'csv_loadable'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(game_teams_path, game_path, teams_path, csv_loadable = CsvLoadable.new)
    @games      = csv_loadable.load_csv_data(game_path, Game)
    @teams      = csv_loadable.load_csv_data(teams_path, Team)
    @game_teams = csv_loadable.load_csv_data(game_teams_path, GameTeam)
  end

  def self.from_csv(locations)
    game_teams_path = locations[:game_teams]
    games_path      = locations[:games]
    teams_path      = locations[:teams]
    new(game_teams_path, games_path, teams_path)
  end

  #Game Statistics

  def highest_total_score
    scores = @games.max_by do |game|
      game.total_goals
    end
    scores.total_goals
  end

  def lowest_total_score
    scores = @games.min_by do |game|
      game.total_goals
    end
    scores.total_goals
  end

  def percentage_home_wins
    games = @game_teams.find_all do |game_team|
      game_team if game_team.hoa == "home"
    end
    wins = games.find_all do |game|
      game if game.result == "WIN"
    end
    percentage(wins, games)
  end

  def percentage_visitor_wins
    games = @game_teams.find_all do |game_team|
      game_team if game_team.hoa == "away"
    end
    wins = games.find_all do |game|
      game if game.result == "WIN"
    end
    percentage(wins, games)
  end

  def percentage_ties #game_team manager
    games = @game_teams
    ties = @game_teams.find_all do |game|
      game if game.result == "TIE"
    end
    percentage(ties, games)
  end

  def percentage(array1, array2)
    percent = array1.length.to_f / array2.length.to_f
    readable_percent = percent.round(2)
  end

  def count_of_games_by_season
    #	A hash with season names (e.g. 20122013) as keys and counts of games as values
    hash = Hash.new(0)

     @games.each do |game|
      hash[game.season.to_s] += 1
     end
     hash
  end

  def count_goals

    #	A hash with season names (e.g. 20122013) as keys and counts of games as values
    hash = Hash.new(0)

     @games.each do |game|
         hash[game.season.to_s] += game.away_goals + game.home_goals
        # require 'pry'; binding.pry
      end
     hash
   end

  def average_goals_per_game
    #Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)
    total_goals = @games.sum do |game|
                    game.away_goals + game.home_goals
                  end
    (total_goals/(@games.count.to_f)).round(2)
    # require 'pry'; binding.pry
  end

  def average_goals_by_season
    #Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)

   #sort out each season
   #calculate how many goals in each season
   #calculate how many games are in each season
   #divide number of goals by number of games
   #make that number the value in the hash
    game_season_totals = count_of_games_by_season
    goal_totals = count_goals

    hash = Hash.new(0)

    @games.each do |game|
      # require 'pry'; binding.pry
      hash[game.season] = (goal_totals[game.season].to_f/game_season_totals[game.season].to_f).round(2)
    end
    hash
  end
  # def quick_count
  #   @games.count
  # end

  #League Statistics

  def count_of_teams
    counter = 0
    @teams.each do |team|
      counter += 1
    end
    counter
  end

  def best_offense
    data = calculate_average_scores
    team_max = data.max_by {|team_id, average_goals| average_goals}

    get_team_name(team_max)
  end

  def worst_offense
    data = calculate_average_scores
    team_min = data.min_by {|team_id, average_goals| average_goals}
    get_team_name(team_min)
  end

  def highest_scoring_visitor
    data = calculate_home_or_away_average("away")

    team_max = data.max_by {|team_id, average_goals| average_goals}
    get_team_name(team_max)
  end

  def lowest_scoring_visitor
    data = calculate_home_or_away_average("away")

    team_min = data.min_by {|team_id, average_goals| average_goals}
    get_team_name(team_min)
  end

  def highest_scoring_home_team
    data = calculate_home_or_away_average("home")

    team_max = data.max_by {|team_id, average_goals| average_goals}
    get_team_name(team_max)
  end

  def lowest_scoring_home_team
    data = calculate_home_or_away_average("home")

    team_min = data.min_by {|team_id, average_goals| average_goals}
    get_team_name(team_min)
  end

  #helper_methods
  def calculate_home_or_away_average(status)
    scores = Hash.new

    @game_teams.each do |game_team|
      if scores[game_team.team_id] == nil && game_team.hoa == status
        scores[game_team.team_id] = []
        scores[game_team.team_id] << game_team.goals
      elsif game_team.hoa == status
        scores[game_team.team_id] << game_team.goals
      end
    end
    data = Hash[scores.map { |team_id, goals| [team_id, (goals.sum.to_f / goals.length.to_f.round(2))]} ]
  end

  def calculate_average_scores
    scores = Hash.new
    @game_teams.each do |game_team|
      if scores[game_team.team_id] == nil
        scores[game_team.team_id] = []
        scores[game_team.team_id] << game_team.goals
      else
        scores[game_team.team_id] << game_team.goals
      end
    end
    data = Hash[scores.map { |team_id, goals| [team_id, (goals.sum.to_f / goals.length.to_f).round(2)]} ]
  end

  def get_team_name(team_data)
     @teams.find do |team|
      if team.team_id == team_data[0]
        return team.teamname.to_s
      end
    end
  end

  #Season Statistics



  #Team Statistics

  def winningest_coach(season_id)
    winners = []
    season = Hash.new { |hash, key| hash[key] = [] }
    @games.each do |game|
      season[game.season] << game.game_id
    end
    teams_that_won = season[season_id].find_all do |game_id|
      winners << @game_teams.find do |teams|
        teams.game_id == game_id && teams.result == "WIN"
      end
    end
    winners = winners.compact
    coaches = winners.map { |winner| winner.head_coach }
    coach_count = Hash.new(0)
    coaches.each { |coach| coach_count[coach] += 1 }
    coach_count.sort_by { |coach, number| number }.last[0]
  end

  def worst_coach(season_id)
    winners = []
    season = Hash.new { |hash, key| hash[key] = [] }
    @games.each do |game|
      season[game.season] << game.game_id
    end
    teams_that_won = season[season_id].find_all do |game_id|
      winners << @game_teams.find do |teams|
        teams.game_id == game_id && teams.result == "LOSS"
      end
    end
    winners = winners.compact
    coaches = winners.map { |winner| winner.head_coach }
    coach_count = Hash.new(0)
    coaches.each { |coach| coach_count[coach] += 1 }
    coach_count.sort_by { |coach, number| number }.first[0]
  end

end
