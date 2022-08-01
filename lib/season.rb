class Season
  attr_reader :season_id,
              :games_in_season

  def initialize(season_id, games_in_season)
    @season_id = season_id
    @games_in_season = games_in_season
  end

  def tackles_by_team
    team_tackles = Hash.new(0)
    @games_in_season.each do |game|
      game.teams_game_stats.values.each do |team_stats_hash|
        team_tackles[team_stats_hash[:team_name]] += team_stats_hash[:tackles]
      end
    end
    team_tackles
  end

  def most_tackles
    tackles_by_team.max_by{|team, tackles| tackles}.first
  end

  def fewest_tackles
    tackles_by_team.min_by{|team, tackles| tackles}.first
  end

  def shots_by_team_per_season_avg(season_id)
    shots_and_goals = Hash.new{|hash, team_name| hash[team_name] = Hash.new(0)}
    @games_in_season.each do |game|
      away_team = game.teams_game_stats[:away_team][:team_name]
      home_team = game.teams_game_stats[:home_team][:team_name]
      shots_and_goals[away_team][:goals] += game.teams_game_stats[:away_team][:goals]
      shots_and_goals[home_team][:goals] += game.teams_game_stats[:home_team][:goals]
      shots_and_goals[home_team][:shots] += game.teams_game_stats[:home_team][:shots]
      shots_and_goals[away_team][:shots] += game.teams_game_stats[:away_team][:shots]
    end
    team_avgs = {}
    shots_and_goals.each do |team_name, stats|
      team_avgs[team_name] = (stats[:goals].to_f / stats[:shots])
    end
    team_avgs
  end

  def most_accurate_team(season_id)
    shots_by_team_per_season_avg(season_id).max_by{ |team_name, avg_shots | avg_shots}.first
  end

  def least_accurate_team(season_id)
    shots_by_team_per_season_avg(season_id).min_by{ |team_name, avg_shots| avg_shots}.first
  end

  def coach_percentages
    games_results = Hash.new{|hash, coach| hash[coach] = []}
    @games_in_season.each do |game|
      away_team_stats = game.teams_game_stats[:away_team]
      home_team_stats = game.teams_game_stats[:home_team]
      games_results[away_team_stats[:head_coach]] << away_team_stats[:result]
      games_results[home_team_stats[:head_coach]] << home_team_stats[:result]
    end
    coach_stats = {}
    games_results.each do |coach_name, game_results|
      wins = games_results[coach_name].select{|result| result == "WIN"}.count
      coach_stats[coach_name] = (wins.to_f / game_results.length).round(2)
    end
    coach_stats
  end

  def winningest_coach
    coach_percentages.max_by{|coach_name, percentage_wins| percentage_wins}.first
   end
 
  def worst_coach
    coach_percentages.min_by{|coach_name, percentage_wins| percentage_wins}.first
  end
  
  def self.generate_seasons(games)
    seasons_ids = games.map{|game| game.season}.uniq
    seasons_hash = {}
    seasons_ids.each do |season_id|
      games_in_season = games.find_all do |game|
        game.season == season_id
      end
      seasons_hash[season_id] = Season.new(season_id, games_in_season)
      end
      seasons_hash
  end 
end
