class StatTracker
  attr_reader :games_path, :teams_path, :game_teams_path, :game_collection, :team_collection

  def initialize(stat_tracker_params)
    @games_path = stat_tracker_params[:games]
    @teams_path = stat_tracker_params[:teams]
    @game_teams_path = stat_tracker_params[:game_teams]
    @game_collection = GameCollection.new(@games_path)
    @team_collection = TeamCollection.new(@teams_path)
    @gt_collection = GameTeamCollection.new(@game_teams_path)
  end

  def self.from_csv(stat_tracker_params)
    StatTracker.new(stat_tracker_params)
  end

  def games
    @game_collection.all
  end

  def teams
    @team_collection.all
  end

  def game_teams
    @gt_collection.all
  end

  # GAME STATISTICS
  def highest_total_score
    games.max_by { |game| game.total_goals }.total_goals
  end

  def lowest_total_score
    games.min_by { |game| game.total_goals }.total_goals
  end

  # LEAGUE STATISTICS
  def count_of_teams
    @team_collection.all.count
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
    # returns hash w team_id as key and array of each team's goals in each game as values
    # => {3=>[2, 2, 1], 6=>[3, 3, 2]}

      # ******find a way to turn the values into score averages

    require "pry"; binding.pry

    score_sums = team_scores.inject(0) do |score_sum, (team_id, scores_array)|
      scores_array.sum / scores_array.count.to_f
      score_sum
    end
    # ^ returns nil

    score_sums
    # games_by_team = game_teams.group_by do |game|
    #   game.team_id
    # end

    # group objects in game_teams file by team
    # for each of those groups, identify their average number of goals
    # identify team w highest average
    # return team name
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
end
