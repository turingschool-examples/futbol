module StatTrackerHelper

  def fewest_tackles1(season)
    @all_games = @game_manager.games_by_season(season)
    self.most_tackles1(season)
    @numb2 = @all_tackles.sort_by{ |key, value| value}[0].first
    self.most_accurate_team2(season)
  end

  def least_accurate_team1(season)
    @all_games2 = @game_manager.games_by_season(season)
    self.most_accurate_team1(season)
    @numb2 = @all_goals.sort_by{ |key, value| value}[0].first
    self.most_accurate_team2(season)
  end

  def most_accurate_team3(season)
    @all_games2 = @game_manager.games_by_season(season)
    self.most_accurate_team1(season)
    @numb2 = @all_goals.sort_by{ |key, value| value}[-1].first
    self.most_accurate_team2(season)
  end

  def percentage_ties1
    home_games = @game_teams_manager.count_home_games
   tie_games = @game_teams_manager.home_game_results(home_games)
    @game_teams_manager.percentage_ties(home_games, tie_games[:ties])
  end

  def percentage_visitor_wins1
    home_games = @game_teams_manager.count_home_games
    home_losses = @game_teams_manager.home_game_results(home_games)
    @game_teams_manager.percentage_visitor_wins(home_games, home_losses[:losses])
  end

  def percentage_home_wins1
    home_games = @game_teams_manager.count_home_games
    home_wins = @game_teams_manager.home_game_results(home_games)
   @game_teams_manager.percentage_home_wins(home_games, home_wins[:wins])
  end

  def count_of_games_by_season1
    games_by_season = @game_manager.create_games_by_season_array
    @game_manager.count_of_games_by_season(games_by_season)
  end

  def average_goals_per_game1
    total_goals = @game_manager.collect_all_goals
    @game_manager.average_goals_per_game(total_goals)
  end

  def average_goals_by_season1
    season_goals = @game_manager.collect_goals_by_season
    @game_manager.average_goals_by_season(season_goals)
  end

  def favorite_opponent1(id)
    number = @game_manager.favorite_opponent(id)
    @team_manager.teams_array.select{ |team| team.team_id == number}[0].team_name
  end

  def rival3(id)
    number = @game_manager.rival(id)
    @team_manager.teams_array.select{ |team| team.team_id == number}[0].team_name
  end

  def best_offense1
    game_team = @game_teams_manager.teams_sort_by_average_goal.last
    @team_manager.find_by_id(game_team.team_id).team_name
  end

  def worst_offense1
    game_team = @game_teams_manager.teams_sort_by_average_goal.first
    @team_manager.find_by_id(game_team.team_id).team_name
  end

  def highest_visitor_team1
    team = @game_teams_manager.highest_visitor_team.first
    @team_manager.find_by_id(team).team_name
  end

  def lowest_visitor_team1
    team = @game_teams_manager.lowest_visitor_team.first
    @team_manager.find_by_id(team).team_name
  end

  def winningest_coach2(season)
    @all_games = @game_manager.games_by_season(season)
    self.winningest_coach1(season)
  end

  def worst_coach2(season)
    @all_games1 = @game_manager.games_by_season(season)
    self.worst_coach1(season)
  end

  def highest_home_team1
    team = @game_teams_manager.highest_home_team.first
    @team_manager.find_by_id(team).team_name
  end
end
