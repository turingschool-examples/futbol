module Helper
  def convert_to_team_name(input_team_id)
    team = @teams.find {|team| team.team_id == input_team_id}
    team.team_name
  end

  def total_goals(game)
    game.away_goals + game.home_goals
  end

  def total_games(games)
    games.count
  end

  def total_teams(teams)
    teams.count
  end

  def average_away_goals(input_games)
    sum_away_goals = input_games.sum(&:away_goals)
    sum_away_goals.fdiv(input_games.count)
  end

  def average_home_goals(input_games)
    sum_home_goals = input_games.sum(&:home_goals)
    sum_home_goals.fdiv(input_games.count)
  end

  def average_accuracy(input_games)
    sum_shots = input_games.sum(&:shots)
    sum_goals = input_games.sum(&:goals)
    sum_goals.fdiv(sum_shots)*100
  end

  def game_team_select_season(input_season)
    season_games = @games.select {|game| game.season == input_season}
    game_team_season = []
    season_games.each do |season_game|
      @game_teams.each do |game_team|
        if game_team.game_id == season_game.game_id
          game_team_season << game_team
        end
      end
    end
    game_team_season
  end
end