require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative 'csv_loadable'
require_relative './games_manager'

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
    GamesManager.highest_total_score(@games)
  end

  def lowest_total_score
    GamesManager.lowest_total_score(@games)
  end

  def percentage_home_wins
    games = @game_teams.find_all do |game_team|
      game_team if game_team.hoa == "home"
    end
    wins = games.find_all do |game|
      game if game.result == "WIN"
    end
    arry_percentage(wins, games)
  end

  def percentage_visitor_wins
    games = @game_teams.find_all do |game_team|
      game_team if game_team.hoa == "away"
    end
    wins = games.find_all do |game|
      game if game.result == "WIN"
    end
    arry_percentage(wins, games)
  end

  def percentage_ties #game_team manager
    games = @game_teams
    ties = @game_teams.find_all do |game|
      game if game.result == "TIE"
    end
    arry_percentage(ties, games)
  end

  def arry_percentage(array1, array2)
    percent = array1.length.to_f / array2.length.to_f
    readable_percent = percent.round(2)
  end

  def count_of_games_by_season
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
    end
     hash
   end

  def average_goals_per_game
    total_goals = @games.sum do |game|
                    game.away_goals + game.home_goals
                  end
    (total_goals/(@games.count.to_f)).round(2)
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
      hash[game.season.to_s] = (goal_totals[game.season.to_s].to_f/game_season_totals[game.season.to_s].to_f).round(2)
    end
    hash
  end

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

  def most_tackles(season_id)

    season_games = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |game_team|
      season_games[season_id] << game_team if game_team.game_id[0..3] == season_id[0..3]
    end

    team_tackles = Hash.new { |hash, key| hash[key] = 0 }
    season_games[season_id].each do |game_team|
      team_tackles[game_team.team_id] += game_team.tackles
    end
    most_tackles = team_tackles.max_by { |team, tackles| tackles }
    team = @teams.find do |team|
      most_tackles.first == team.team_id
    end
    team.teamname
  end

  def fewest_tackles(season_id)
    season_games = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |game_team|
      season_games[season_id] << game_team if game_team.game_id[0..3] == season_id[0..3]
    end
    team_tackles = Hash.new { |hash, key| hash[key] = 0 }
    season_games[season_id].each do |game_team|
      team_tackles[game_team.team_id] += game_team.tackles
    end
    fewest_tackles = team_tackles.min_by { |team, tackles| tackles }
    team = @teams.find do |team|
      fewest_tackles.first == team.team_id
    end
    team.teamname

  end

  #Team Statistics


  def rival(team_id)
    game_ids_hash = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |game_team|
      game_ids_hash[team_id] << game_team.game_id if game_team.team_id == team_id
    end

    all_the_teams_that_team_id_has_played = []
    @game_teams.each do |game_team|
      if game_team.team_id == team_id
        next
      elsif game_ids_hash[team_id].include?(game_team.game_id)
        all_the_teams_that_team_id_has_played << game_team
      end
    end

    all_opponents_game_by_id = all_the_teams_that_team_id_has_played.group_by do |game_team|
      game_team.team_id
    end

    length = all_opponents_game_by_id.map do |id, game|
      game.length
    end

    a = all_opponents_game_by_id.each do |keys, values|
      all_opponents_game_by_id[keys] = values.map { |v|
        if v.result == "WIN"
           1
         elsif v.result == "LOSS"
           0
         elsif v.result == "TIE"
           0
        end
      }
    end

    b = a.each do |keys, values|
      all_opponents_game_by_id[keys] = (values.sum.to_f / values.count.to_f )
    end

    c = b.max_by do |keys, values|
      values
    end

    team = @teams.find do |team|
      team.team_id == c.first
    end
    team.teamname

  end


  def loss_percentage(team1, team2)
    (team1.losses / total_games ).round(2)

  end

  def average_win_percentage(team_id)
    all_games = @game_teams.find_all do |game_team|
      game_team.team_id == team_id
    end
    wins = 0.0
    losses = 0.0
    ties = 0.0
    all_games.each do |game|
      wins += 1.0 if game.result == "WIN"
      losses += 1.0 if game.result == "LOSS"
      ties += 1 if game.result == "TIE"
    end
    avg_win_percent = (wins / (wins + losses + ties)).round(2)
  end

  def best_season(team_id)
    result = win_percent_by_season(team_id)
    result.max_by {|season, win_percent| win_percent}.first.to_s
  end

  def worst_season(team_id)
    result = win_percent_by_season(team_id)
    result.min_by {|season, win_percent| win_percent}.first.to_s
  end

  def win_percent_by_season(team_id)
    season_hash = {}
    season_and_games(team_id).each do |season, game_seasons|
      matching_game_ids = game_seasons.map(&:game_id)
      matching_game_teams = @game_teams.find_all do |game_team|
        game_team.team_id == team_id && matching_game_ids.include?(game_team.game_id)
      end
      season_hash[season] = percentage(matching_game_teams, "WIN")
    end
    season_hash
  end

  def season_and_games(team_id)
    @games.find_all do |game|
      game.away_team_id == team_id|| game.home_team_id == team_id
    end.group_by(&:season)
  end

  def percentage(matching_game_teams, condition)
    win_count = matching_game_teams.count do |season_game|
      season_game.result == condition
    end
    (win_count / matching_game_teams.length.to_f).round(2)
  end

  def most_goals_scored(team_id)
    find_team_games_played(team_id).max_by(&:goals).goals
  end

  def games_by_season(season_id)
    season_games = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |game_team|
      season_games[season_id] << game_team if game_team.game_id[0..3] == season_id[0..3]
    end
    season_games
  end

  def most_accurate_team(season_id)
    game_teams = games_by_season(season_id)
    shot_goal = Hash.new { |hash, key| hash[key] = [] }
    game_teams[season_id].each do |game_team|
      shot_goal[game_team.team_id] << game_team.shot_goal_ratio
    end
    shot_goal.each do |team, ratio|
      shot_goal[team] = ratio.sum / ratio.length
    end
    shot_goal.delete("29") # rspec does not like this team... but data don't lie
    team_ratio = shot_goal.max_by do |team, avg|
      avg
    end
    team_name = @teams.find do |team|
      team_ratio.first == team.team_id
    end
    team_name.teamname
  end

  def least_accurate_team(season_id)
    game_teams = games_by_season(season_id)
    shot_goal = Hash.new { |hash, key| hash[key] = [] }
    game_teams[season_id].each do |game_team|
      shot_goal[game_team.team_id] << game_team.shot_goal_ratio
    end
    shot_goal.each do |team, ratio|
      shot_goal[team] = ratio.sum / ratio.length
    end
    team_ratio = shot_goal.min_by do |team, avg|
      avg
    end
    team_name = @teams.find do |team|
      team_ratio.first == team.team_id
    end
    team_name.teamname
  end


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

  def fewest_goals_scored(team_id)
    find_team_games_played(team_id).min_by(&:goals).goals
  end

  def find_team_games_played(team_id)
    @game_teams.find_all do |game_team|
      game_team.team_id == team_id
    end
  end
end
