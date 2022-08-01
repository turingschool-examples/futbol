class League
  attr_reader :all_games, :all_teams, :all_game_teams

  def initialize(all_games, all_teams, all_game_teams)
    @all_games = all_games
    @all_teams = all_teams
    @all_game_teams = all_game_teams
  end

  def total_goals_array
    @all_games.map do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end
  end

  def games_by_season
    games_by_season = Hash.new(0)
    @all_games.each do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
  end

  def team_names
    @all_teams.map do |team|
      team.team_name
    end.uniq
  end

  def goals_by_team_id
    goals_by_team_id = Hash.new {|h,k| h[k]=[]}
    @all_game_teams.each do |game|
      goals_by_team_id[game.team_id] << game.goals.to_i
    end
    goals_by_team_id
  end

  def avg_goals_by_team_id
    avg_goals_by_team_id = Hash.new(0)
    goals_by_team_id.each do |team_id, goals|
      avg_goals_by_team_id[team_id] = (goals.sum(0.0) / goals.length).round(2)
    end
    avg_goals_by_team_id
  end

end
