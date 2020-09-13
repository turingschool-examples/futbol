class GameTeamsManager
  attr_reader :game_teams_data,
              :tracker

  def initialize(location, tracker)
    @game_teams_data = game_teams_stats(location)
    @tracker = tracker
  end

  def game_teams_stats(location)
    rows = CSV.read(location, { encoding: 'UTF-8', headers: true, header_converters: :symbol})
    result = []
    rows.each do |gameteam|
      gameteam.delete(:pim)
      gameteam.delete(:powerPlayOpportunities)
      gameteam.delete(:powerPlayGoals)
      gameteam.delete(:faceOffWinPercentage)
      gameteam.delete(:giveaways)
      gameteam.delete(:takeaways)
      result << GameTeams.new(gameteam, self)
    end
    result
  end

  def all_home_wins
    @game_teams_data.select do |game_team|
      game_team.hoa == "home" && game_team.result == "WIN"
    end
  end

  def all_visitor_wins
    @game_teams_data.select do |game_team|
      game_team.hoa == "away" && game_team.result == "WIN"
    end
  end

  def count_of_ties
    double_ties = @game_teams_data.find_all do |game_team|
      game_team.result == "TIE"
    end
    double_ties.count / 2
  end

  def group_by_team_id
    @game_teams_data.group_by do |team|
      team.team_id
    end
  end

  def hash_of_seasons(season) #refactor: move to module
    @game_teams_data.find_all do |game_team|
      game_team.game_id.to_s.split('')[0..3].join.to_i == season.split('')[0..3].join.to_i
    end
  end

  def group_by_coach(season)
    hash_of_seasons(season).group_by {|game| game.head_coach}
  end
  #
  def coach_wins(season)
    hash = {}
    group_by_coach(season).map do |coach, games|
      total_wins = 0
      total_games = 0
      games.each do |game|
        total_wins += 1 if game.result == 'WIN'
        total_games += 1
      end
      hash[coach] = (total_wins.to_f / total_games).round(3)
    end
    hash
  end
  #
  def winningest_coach(season)
   best_coach =  coach_wins(season).max_by {|coach, win| win}
    best_coach[0]
  end

  def worst_coach(season)
   worst_coach =  coach_wins(season).min_by {|coach, win| win}
    worst_coach[0]
  end

  def find_by_team_id(season)
    hash_of_seasons(season).group_by {|team| team.team_id}
  end

  def most_accurate_team(season)
    @tracker.team_manager.most_accurate_team(season)
  end

  def find_most_accurate_team(season)
    most_accurate = goals_to_shots_ratio_per_season(season).sort_by {|team_id, goals| goals}
    most_accurate[-1][0]
  end

  def goals_to_shots_ratio_per_season(season)
    total_goals = {}
    find_by_team_id(season).each do |team_id, rows|
      sum_goals = rows.sum {|row| row.goals}
      sum_shots = rows.sum {|row| row.shots}
      total_goals[team_id] = (sum_goals.to_f / sum_shots).round(3) * 100
    end
    total_goals
  end

  def find_least_accurate_team(season)
    least_accurate = goals_to_shots_ratio_per_season(season).sort_by {|team_id, goals| goals}
    least_accurate[0][0]
  end

  def least_accurate_team(season)
    @tracker.team_manager.least_accurate_team(season)
  end

  def most_tackles(season)
    @tracker.team_manager.most_tackles(season)
  end

  def find_team_with_most_tackles(season)
    team = total_tackles(season).sort_by {|team_id, tackles| tackles}
    team[-1][0]
  end

  def total_tackles(season)
    total_tackles = {}
    find_by_team_id(season).each do |team_id, rows|
      sum_tackles = rows.sum {|row| row.tackles}
      total_tackles[team_id] = sum_tackles
    end
    total_tackles
  end

  def find_team_with_fewest_tackles(season)
    team = total_tackles(season).sort_by {|team_id, tackles| tackles}
    team[0][0]
  end

  def fewest_tackles(season)
    @tracker.team_manager.fewest_tackles(season)
  end

  def all_team_games(team_id)
    @game_teams_data.find_all do |game_team|
      game_team.team_id == team_id.to_i
    end
  end
end
