require_relative './helper_class'

class StatTracker
  attr_reader :game_teams_factory,
              :teams_factory,
              :game_factory,
              :all_games,
              :all_teams,
              :all_game_teams

  def initialize
    @game_teams_factory = GameTeamFactory.new
    @teams_factory = Teams_factory.new
    @game_factory = GameFactory.new
    @all_games = []
    @all_teams = []
    @all_game_teams = []
  end

  def self.from_csv(source)
    stattracker = StatTracker.new

    source.each do |key, value|
      case key
      when :games
        stattracker.game_factory.create_games(value)
      when :teams
        stattracker.teams_factory.create_teams(value)
      when :game_teams
        stattracker.game_teams_factory.create_game_teams(value)
      end
    end

    stattracker.instance_variable_set(:@all_games, stattracker.game_factory.games)
    stattracker.instance_variable_set(:@all_teams, stattracker.teams_factory.teams)
    stattracker.instance_variable_set(:@all_game_teams, stattracker.game_teams_factory.game_teams)

    stattracker
  end

  def percentage_home_wins
    total_games = @all_games.length
    home_wins = @all_games.count {|game| game.home_goals > game.away_goals}
          
    percentage = (home_wins.to_f / total_games) * 100
    percentage.round(2)
  end

  def count_of_all_goals
    all_goals = 0
    @all_games.each do |game|
      game_goals = game.away_goals.to_i + game.home_goals.to_i
      all_goals += game_goals
    end
    all_goals
  end

  def percentage_visitor_wins
    total_games = @all_games.length
    visitor_wins = @all_games.count {|game| game.away_goals > game.home_goals}
          
    percentage = (visitor_wins.to_f / total_games) * 100
    percentage.round(2)
  end

  def percentage_ties
    total_games = @all_games.length
    ties = @all_games.count {|game| game.away_goals == game.home_goals}
          
    percentage = (ties.to_f / total_games) * 100
    percentage.round(2)
  end

  def best_offense
    team_goals = {}
    team_games = {}

    @all_game_teams.each do |game_team|
      team_id = game_team.team_id
      goals = game_team.goals.to_i

      team_goals[team_id] ||= 0
      team_goals[team_id] += goals

      team_games[team_id] ||= 0
      team_games[team_id] += 1
    end

    team_averages = team_goals.map do |team_id, total_goals|
      games_played = team_games[team_id]
      average_goals = total_goals.to_f / games_played
      [team_id, average_goals]
    end

    best_team_id = team_averages.max_by { |_,avg| avg }.first
    best_team = @all_teams.find {|team| team.team_id == best_team_id}

    best_team.teamName
  end

  def worst_offense
    team_goals = {}
    team_games = {}
  
    @all_game_teams.each do |game_team|
      team_id = game_team.team_id
      goals = game_team.goals.to_i
  
      team_goals[team_id] ||= 0
      team_goals[team_id] += goals
  
      team_games[team_id] ||= 0
      team_games[team_id] += 1
      end
  
      team_averages = team_goals.map do |team_id, total_goals|
        games_played = team_games[team_id]
        average_goals = total_goals.to_f / games_played
        [team_id, average_goals]
      end
  
      worst_team_id = team_averages.min_by { |_,avg| avg }.first
      worst_team = @all_teams.find {|team| team.team_id == worst_team_id}
  
      worst_team.teamName
  end

  def average_goals_per_game
    average = count_of_all_goals / @all_games.count.to_f
  average.round(2)
  end

  def average_goals_season
    # TODO: required
    # Average number of goals scored in a game organized
    # in a hash with season names (e.g. 20122013) as keys
    # and a float representing the average number of goals
    # in a game for that season as values (rounded to the nearest 100th)
    # returns hash
  end

  def get_average(scores)
    # TODO: helper method
    # returns float
  end

  def get_sum(scores)
    # TODO: helper method
    # returns int
  end

  def get_scores(team_id, hoa = :both)
    no_goals = [0] # only needed if there are no goals
    team_id = team_id.to_i # team_id can be provided as int or str

    away_games = @all_games.select { |game| game.away_team_id.to_i == team_id }
    home_games = @all_games.select { |game| game.home_team_id.to_i == team_id }

    return no_goals unless home_games.any? || away_games.any?

    home_goals = []
    home_games.each { |game| home_goals << game.home_goals.to_i } if home_games

    away_goals = []
    away_games.each { |game| away_goals << game.away_goals.to_i } if away_games

    if hoa == :home
      home_goals
    elsif hoa == :away
      away_goals
    else
      home_goals + away_goals
    end
  end

  def highest_total_score
    scores = @all_games.map do |game|
      game.home_goals + game.away_goals
    end
    scores.max
  end

  def lowest_total_score
    scores = @all_games.map do |game|
      game.home_goals + game.away_goals
    end
    scores.min
  end

  def highest_scoring_visitor
    all_visitor_scores = {}
    @all_teams.each do |team|
      goals = get_scores(team.team_id, :away).sum
      all_visitor_scores[team] = goals
    end
    all_visitor_scores.max_by{|team,goals| goals}.first.teamName
  end

  def highest_scoring_home_team
    all_home_scores = {}
    @all_teams.each do |team|
      goals = get_scores(team.team_id, :home).sum
      all_home_scores[team] = goals
    end
    all_home_scores.max_by{|team,goals| goals}.first.teamName
  end

  def lowest_scoring_visitor
    all_visitor_scores = {}
    @all_teams.each do |team|
      goals = get_scores(team.team_id, :away).sum
      all_visitor_scores[team] = goals
    end
    all_visitor_scores.min_by{|team,goals| goals}.first.teamName
  end

  def lowest_scoring_home_team
    all_home_scores = {}
    @all_teams.each do |team|
      goals = get_scores(team.team_id, :home).sum
      all_home_scores[team] = goals
    end
    all_home_scores.min_by{|team,goals| goals}.first.teamName
  end

  def coach_win_percentages(season)
    coach_games = Hash.new { |hash, key| hash[key] = { wins: 0, games: 0}}
    @all_game_teams.each do |game_team|
      game = @all_games.find { |g| g.game_id == game_team.game_id }
      next if season && game.season != season.to_s
      coach = game_team.head_coach
      coach_games[coach][:games] += 1
      coach_games[coach][:wins] += 1 if game_team.result == "WIN"
    end
    coach_games.transform_values do |stats| 
      games = stats[:games]
      games > 0 ? ((stats[:wins].to_f / games) * 100).round : 0
    end
  end

  def winningest_coach(season = nil)
    coach_win_percentages(season).max_by { |coach, win_percentage| win_percentage}.first
  end

  def worst_coach(season = nil)
    coach_win_percentages(season).min_by { |coach, win_percentage| win_percentage}.first
  end
end
