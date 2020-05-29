require_relative './game'
require_relative './team'
require_relative './game_team'

class StatTracker
  attr_reader :games_path, :teams_path, :game_teams_path, :games, :teams, :game_teams

  def initialize(stat_tracker_params)
    @games_path = stat_tracker_params[:games]
    @teams_path = stat_tracker_params[:teams]
    @game_teams_path = stat_tracker_params[:game_teams]

    @games = Game.all(@games_path)
    @teams = Team.all(@teams_path)
    @game_teams = GameTeam.all(@game_teams_path)
  end

  def self.from_csv(stat_tracker_params)
    StatTracker.new(stat_tracker_params)
  end

  # GAME STATISTICS

  def highest_total_score
    games.max_by { |game| game.total_goals }.total_goals
  end

  def lowest_total_score
    games.min_by { |game| game.total_goals }.total_goals
  end

  def find_home_wins
    game_teams.find_all do |game_team|
      game_team.hoa == "home" && game_team.result == "WIN"
    end
  end

  def percentage_home_wins
    percentage = find_home_wins.count.fdiv(game_teams.count / 2) * 100
    percentage.round(2)
  end

  # LEAGUE STATISTICS
  def count_of_teams
    teams.count
  end

  # def find_team_by_id(id)
  #   teams.find do |team|
  #     team.team_id == id
  #   end
  # end

  def find_team_by_id(id)
    @teams.find do |team|
      team.team_id == id
    end
  end

  def best_offense
    team_scores = game_teams.reduce({}) do |team_scores, game|
      if team_scores[game.team_id].nil?
        team_scores[game.team_id] = [game.goals]
      else
        team_scores[game.team_id] << game.goals
      end
      team_scores
    end

    average_scores = {}
    team_scores.each do |team, scores_array|
      average_scores[team] = (scores_array.sum / scores_array.count.to_f)
    end

    highest_avg_score = average_scores.max_by do |team, average_score|
      average_score
    end

    find_team_by_id(highest_avg_score.first).team_name

  end

  def worst_offense
    # use same set up as above
    # but then identify team w lowest average
    # return team name
  end

  def highest_scoring_visitor
    # identify all objects identified as away games in game_teams
    # amongst the list of away games, group objects by team
    # for each group, identify average number of goals
    # identify team w highest average
    # return team name
  end

  def highest_scoring_home_team
    # same as above but w home games instead of away games
  end

  def lowest_scoring_visitor
    # same as highest_scoring_visitor but find team w lowest average
  end

  def lowest_scoring_home_team
    # same as above but w home games
  end

  # SEASON STATISTIC

  # TEAM STATISTICS

  def team_info(id)
    teams.find do |team|
      team.team_id == id
    end.info
  end

  def most_goals_scored(team_id)
    game_teams.reduce([]) do |scores, game_team|
      scores << game_team.goals if game_team.team_id == team_id
      scores
    end.max
  end

  def fewest_goals_scored(team_id)
    game_teams.reduce([]) do |scores, game_team|
      scores << game_team.goals if game_team.team_id == team_id
      scores
    end.min
  end

  def best_season(team_id)
    # Create array of game_team objects with matching team_id and WINs
    # (this could be a GameTeamCollection find_by method!!
    # maybe split up the matching by team_id and matching by result)
    game_teams_won = game_teams.find_all do |game_team|
      game_team.team_id == team_id && game_team.result == "WIN"
    end

    # Cross-reference game_teams with games:
    games_won = []
    game_teams_won.each do |game_team|
      games.each do |game|
        games_won << game if game_team.game_id == game.game_id
      end
    end

    # Using cross-referenced game list, create hash with season as keys,
    # and won [Game objects array] as values
    season_hash = games_won.group_by do |game|
      game.season
    end

    # Count up the number of games for each season (remember these are "wins")
    # For some reason, calling max_by on a hash returns an array.
    season_with_most_wins = season_hash.max_by do |season, games|
      games.count
    end

    # so then I called the would-be key by using index 0 in the array
    season_with_most_wins[0].to_s
  end

end
