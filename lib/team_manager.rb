class TeamManager
  attr_reader :team_data,
              :tracker

  def initialize(location, tracker)
    @team_data = teams_stats(location)
    @tracker = tracker
  end

  def teams_stats(location)
    teams_data = CSV.read(location, { encoding: 'UTF-8', headers: true, header_converters: :symbol, converters: :all })
    result = []
    teams_data.each do |team|
      team.delete(:stadium)
      result << Team.new(team, self)
    end
    result
  end

  def count_of_teams
    @team_data.length
  end

  def group_by_team_id
    @tracker.game_teams_manager.group_by_team_id
  end

  def team_id_and_average_goals
    average_goals_by_team = {}
    group_by_team_id.each do |team, games|
      total_games = games.map { |game| game.game_id }
      total_goals = games.sum { |game| game.goals }
      average_goals_by_team[team] = (total_goals.to_f / total_games.count).round(2)
    end
    average_goals_by_team
  end

  def best_offense
    best_attack = @team_data.find do |team|
      team.teamname if best_offense_stats == team.team_id
    end
    best_attack.teamname
  end

  def worst_offense
    worst_attack = @team_data.find do |team|
      team.teamname if worst_offense_stats == team.team_id
    end
    worst_attack.teamname
  end

  def best_offense_stats
    stats = team_id_and_average_goals.sort_by do |key, value|
      value
    end
    stats[-1][0]
  end

  def worst_offense_stats
    stats = team_id_and_average_goals.sort_by do |key, value|
      value
    end
    stats[0][0]
  end

  def team_id_and_average_away_goals
    away_team_goals = {}
    group_by_team_id.each do |team, games|
      away_games = games.find_all { |game| game.hoa == 'away' }
      away_goals = away_games.sum { |game| game.goals }
      away_team_goals[team] = (away_goals.to_f / away_games.count).round(3)
    end
    away_team_goals
  end

  def team_highest_away_goals
    away_goals = team_id_and_average_away_goals.sort_by do |team, goals|
      goals
    end
    away_goals[-1][0]
  end

  def highest_scoring_visitor
    visitor = @team_data.find do |team|
      team.teamname if team_highest_away_goals == team.team_id
    end
    visitor.teamname
  end

  def team_lowest_away_goals
    away_goals = team_id_and_average_away_goals.sort_by do |team, goals|
      goals
    end
    away_goals[0][0]
  end

  def lowest_scoring_visitor
    visitor = @team_data.find do |team|
      team.teamname if team_lowest_away_goals == team.team_id
    end
    visitor.teamname
  end

  def team_id_and_average_home_goals
    home_team_goals = {}
    group_by_team_id.each do |team, games|
      home_games = games.find_all { |game| game.hoa == 'home' }
      home_goals = home_games.sum { |game| game.goals }
      home_team_goals[team] = (home_goals.to_f / home_games.count).round(3)
    end
    home_team_goals
  end

  def team_highest_home_goals
    home_goals = team_id_and_average_home_goals.sort_by do |team, goals|
      goals
    end
    home_goals[-1][0]
  end

  def highest_scoring_home_team
    home = @team_data.find do |team|
      team.teamname if team_highest_home_goals == team.team_id
    end
    home.teamname
  end

  def team_lowest_home_goals
    home_goals = team_id_and_average_home_goals.sort_by do |team, goals|
      goals
    end
    home_goals[0][0]
  end

  def lowest_scoring_home_team
    home = @team_data.find do |team|
      team.teamname if team_lowest_home_goals == team.team_id
    end
    home.teamname
  end

  def most_accurate_team(season)
    accurate = @team_data.find do |team|
      team.teamname if @tracker.game_teams_manager.find_most_accurate_team(season) == team.team_id
    end
    accurate.teamname
  end

  def least_accurate_team(season)
    not_accurate = @team_data.find do |team|
      team.teamname if @tracker.game_teams_manager.find_least_accurate_team(season) == team.team_id
    end
    not_accurate.teamname
  end

  def most_tackles(season)
    most_tackles = @team_data.find do |team|
      team.teamname if @tracker.game_teams_manager.find_team_with_most_tackles(season) == team.team_id
    end
    most_tackles.teamname
  end

  def fewest_tackles(season)
    fewest_tackles = @team_data.find do |team|
      team.teamname if @tracker.game_teams_manager.find_team_with_fewest_tackles(season) == team.team_id
    end
    fewest_tackles.teamname
  end

  # def group_teams_data
  #   @team_data.find_all do |row|
  #     require "pry"; binding.pry
  #     row.team_id
  #   end
  # end

  def team_info(team_id)
    hash = {}
    @team_data.each do |team|
      if team_id == team.team_id.to_s
        hash['team_id'] = team.team_id.to_s
        hash['franchiseid'] =  team.franchiseid.to_s
        hash['teamname'] = team.teamname
        hash['abbreviation'] = team.abbreviation
        hash['link'] = team.link
      end
    end
    hash
  end

  def all_team_games(team_id)
    @tracker.game_teams_manager.all_team_games(team_id)
  end

  def group_by_season(team_id)
    all_team_games(team_id).group_by do |game|
      game.game_id.to_s[0..3]
    end
  end

  def percent_wins_by_season(team_id)
    wins = {}
    group_by_season(team_id).each do |season, games|
      total_wins = 0
      total_games = 0
      games.each do |game|
        total_wins += 1 if game.result == "WIN"
        total_games += 1
      end
      wins[season] = (total_wins.to_f / total_games).round(3)
    end
    wins
  end

  def best_season(team_id)
    best = percent_wins_by_season(team_id).max_by do |season, percent_wins|
      percent_wins
    end
    best_year = best[0].to_i
    result = "#{best_year}201#{best_year.digits[0] + 1}"
  end

  def worst_season(team_id)
    worst = percent_wins_by_season(team_id).min_by do |season, percent_wins|
      percent_wins
    end
    worst_year = worst[0].to_i
    result = "#{worst_year}201#{worst_year.digits[0] + 1}"
  end

  def average_win_percentage(team_id)
  (total_wins(team_id).count.to_f / all_team_games(team_id).count).round(2)
  end

  def total_wins(team_id)
    all_team_games(team_id).find_all do |game|
      game.result == "WIN"
    end
  end

  def most_goals_scored(team_id)
    most = all_team_games(team_id).max_by do |game|
      game.goals
    end
    most.goals
  end

  def fewest_goals_scored(team_id)
    fewest = all_team_games(team_id).min_by do |game|
      game.goals
    end
    fewest.goals
  end

  def find_all_game_ids_by_team(team_id)
    @tracker.game_manager.find_all_game_ids_by_team(team_id)
  end

  def find_opponent_id(team_id)
    find_all_game_ids_by_team(team_id).map do |game|
      if game.home_team_id == team_id
        game.away_team_id
      else
        game.home_team_id
      end
    end
  end

  def hash_by_opponent_id(team_id)
    hash = {}
    find_opponent_id(team_id).each do |game|
      hash[game] = find_all_game_ids_by_team(team_id)
    end
    hash
  end

  def sort_games_against_rival(team_id)
    hash = {}
    hash_by_opponent_id(team_id).each do |rival, games|
      rival_games = games.find_all do |game|
        rival == game.away_team_id || rival == game.home_team_id
      end
      hash[rival] = rival_games
    end
    hash
  end
  #
  def find_count_of_games_against_rival(team_id)
    hash = {}
    sort_games_against_rival(team_id).each do |rival_id, rival_games|
      game_count = rival_games.count
      hash[rival_id] = game_count
    end
    hash
  end

  def find_percent_of_winning_games_against_rival(team_id)
    hash = {}
    sort_games_against_rival(team_id).each do |rival_id, rival_games|
      given_team_win_count = 0
      total_games = 0
      rival_games.each do |game|
        if rival_id == game.away_team_id
          total_games += 1
          if game.away_goals < game.home_goals
            given_team_win_count += 1
          end
        else
          total_games += 1
          if game.home_goals < game.away_goals
            given_team_win_count += 1
          end
        end
      end
      hash[rival_id] = (given_team_win_count.to_f / total_games).round(3) * 100
    end
    hash
  end

  def favorite_opponent_id(team_id)
    fav_opponent = find_percent_of_winning_games_against_rival(team_id).max_by do |rival_id, wins|
      wins
    end
    fav_opponent[0]
  end

  def favorite_opponent(team_id)
    opponent_id = favorite_opponent_id(team_id)
    opponent_name = @team_data.find do |team|
      team.teamname if opponent_id == team.team_id.to_s
    end
    opponent_name.teamname
  end

  def rival_opponent_id(team_id)
    rival_opponent = find_percent_of_winning_games_against_rival(team_id).min_by do |rival_id, wins|
      wins
    end
    rival_opponent[0]
  end

  def rival(team_id)
    opponent_id = rival_opponent_id(team_id)
    opponent_name = @team_data.find do |team|
      team.teamname if opponent_id == team.team_id.to_s
    end
    opponent_name.teamname
  end
end
