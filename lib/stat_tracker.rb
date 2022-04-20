require "csv"
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require_relative 'game_team_stats'
require_relative 'league_stats'
require_relative 'game_stats'
require 'pry'

class StatTracker
  attr_reader :games, :teams, :game_teams, :games_array

  def initialize(locations)
    @game_team_stats = GameTeamStats.new(locations)

    @league_stats = LeagueStats.new(locations)
    @game_stats = GameStats.new(locations)

  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end


  # Season Statistics


  ## Take in an argument that is year/season
  ##organize by team_id
  ##team_id.length, return total_games
  ##look at :result
  ##wins = +1, loss = 0, tie = 0, return win_total
  ##total wins / total games organize_teams["3"].length
  ##return percentage
  ##return a coach based on team_id
  #iterate through year/season to compare percentages
  #return highest percentage and coach

  def winningest_coach(season_id)
    best_team = team_winning_percentage_by_season(season_id).max_by do |team_id, percentage|
        percentage
      end
    head_coach_name(best_team[0])
  end

  def worst_coach(season_id)
    worst_team = team_winning_percentage_by_season(season_id).min_by do |team_id, percentage|
      percentage #look through my percentages
    end
    head_coach_name(worst_team[0])
  end

  def most_accurate_team(season_id)
    best_shot = team_shot_percentage_by_season(season_id).max_by do |team_id, percentage|
      percentage
    end
    team_name(best_shot[0])
  end

  def least_accurate_team(season_id)
    worst_shot = team_shot_percentage_by_season(season_id).min_by do |team_id, percentage|
      percentage
    end
    team_name(worst_shot[0])
  end

  def most_tackles(season_id)
    highest_tackles = total_tackles_by_season(season_id).max_by do |team_id, total_tackles|
      total_tackles
    end
    team_name(highest_tackles[0])
  end

  def least_tackles(season_id)
    lowest_tackles = total_tackles_by_season(season_id).min_by do |team_id, total_tackles|
      total_tackles
    end
    team_name(lowest_tackles[0])
  end

  def games_by_season(season_id) # Take in an argument that is year/season converts game_id to year, returns :year{[games]}
    year = season_id[0..3]
    @game_teams.find_all do |game_team|
      game_team.game_id[0..3] == year
    end
  end

  def organize_teams(season_id) #organize by team_id returns :team_id{[games]}
    team_hash = games_by_season(season_id).group_by {|game| game.team_id}
  end

  def team_winning_percentage_by_season(season_id) #calculates/returns winning percentage
    win_percentage_hash = {}
    organize_teams(season_id).each do |team_id,game_teams|
      number_of_wins = 0
      game_teams.each do |game_team|
        if game_team.result == "WIN"
          number_of_wins += 1
        end
      end
        total_games = game_teams.count
        win_percentage = number_of_wins.to_f / total_games.to_f
        win_percentage_hash[team_id] = win_percentage.round(2)
      end
      win_percentage_hash
  end

  def team_shot_percentage_by_season(season_id) #calculates/returns winning percentage
    shot_percentage_hash = {}
    organize_teams(season_id).each do |team_id,game_teams|
      number_of_goals = 0
      number_of_shots = 0
      game_teams.each do |game_team|
          number_of_goals += game_team.goals
          number_of_shots += game_team.shots
        end
        shot_percentage = number_of_goals.to_f / number_of_shots.to_f
        shot_percentage_hash[team_id] = shot_percentage.round(2)
      end
      shot_percentage_hash
  end

  def total_tackles_by_season(season_id)
    tackle_total_hash = {}
    organize_teams(season_id).each do |team_id,game_teams|
      number_of_tackles = 0
      game_teams.each do |game_team|
        number_of_tackles += game_team.tackles
      end
      tackle_total_hash[team_id] = number_of_tackles
    end
    tackle_total_hash
  end

  def head_coach_name(team_id) #return a coach based on team_id
    game_team_by_id = @game_teams.find do |game_team|
      game_team.team_id == team_id
    end
    game_team_by_id.head_coach
  end

  def team_name(team_id)
    team_name_by_id = @teams.find do |team|
      team.team_id == team_id
    end
    team_name_by_id.team_name
  end

  # Team Statistics
  def team_info(team_id)
    @game_team_stats.team_info(team_id)
  end

  def season_games(game_id)
    @game_team_stats.season_games(game_id)
  end

  def best_season(team_id)
    @game_team_stats.best_season(team_id)
  end

  def worst_season(team_id)
    @game_team_stats.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @game_team_stats.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_team_stats.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_team_stats.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @game_team_stats.favorite_opponent(team_id)
  end

  def rival(team_id)
    @game_team_stats.rival(team_id)
  end


  def count_of_teams
    @league_stats.count_of_teams
  end

  def best_offense
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense
  end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end

  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end 


end
