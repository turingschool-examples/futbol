class Team

  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  attr_accessor :games_participated_in

  def initialize(teams_csv_row)
    @team_id = teams_csv_row[:team_id]
    @franchise_id = teams_csv_row[:franchiseid]
    @team_name = teams_csv_row[:teamname]
    @abbreviation = teams_csv_row[:abbreviation]
    @stadium = teams_csv_row[:stadium]
    @link = teams_csv_row[:link]
    @games_participated_in = []
  end

  def total_overall_goals
    @games_participated_in.sum do |game|
      if game.teams_game_stats[:home_team][:team_id] == @team_id
        game.teams_game_stats[:home_team][:goals]
      else
        game.teams_game_stats[:away_team][:goals]
      end
    end
  end

  def total_goals_per_side(key_of_side)
    @games_participated_in.sum do |game|
      if game.teams_game_stats[key_of_side][:team_id] == @team_id
        game.teams_game_stats[key_of_side][:goals]
      else
        0
      end
    end
  end

  def opponent_win_percentages
    opp_win_percentages = Hash.new {|hash, team| hash[team] = Hash.new(0)}
    @games_participated_in.each do |game|
      home_name = game.teams_game_stats[:home_team][:team_name]
      away_name = game.teams_game_stats[:away_team][:team_name]
      if home_name == @team_name
        opp_win_percentages[away_name][:total_games] += 1
        opp_win_percentages[away_name][:winning_games] += 1 if game.winner == :away_team
      elsif away_name == @team_name
        opp_win_percentages[home_name][:total_games] += 1
        opp_win_percentages[home_name][:winning_games] += 1 if game.winner == :home_team
      end
    end
    opp_win_percentages.each do |team, stats|
      opp_win_percentages[team] = stats[:winning_games].to_f / stats[:total_games]
    end
  end

  def rival
    opponent_win_percentages.max_by{ |team_name, win_percent| win_percent }.first
  end

  def favorite_opponent
    opponent_win_percentages.min_by{ |team_name, win_percent| win_percent }.first
  end

  def win_percentages_by_season
    season_win_percent = Hash.new{|hash, season| hash[season] = Hash.new(0)}
    @games_participated_in.each do |game|
      if game.team_in_game?(@team_id)
        season_win_percent[game.season][:total_games] += 1
        season_win_percent[game.season][:winning_games] += 1 if game.team_stats(@team_id)[:result] == "WIN"
      end
    end
    season_win_percent.each do |season_id, stats|
      season_win_percent[season_id] = stats[:winning_games].to_f / stats[:total_games]
    end
    season_win_percent
  end

  def best_season
    win_percentages_by_season.max_by{ |season, win_percent| win_percent }.first.to_s
  end

  def worst_season
    win_percentages_by_season.min_by{ |season, win_percent| win_percent }.first.to_s
  end

  def home_and_away_goals
    @games_participated_in.map do |game|
      if game.teams_game_stats[:home_team][:team_id] == team_id
        game.teams_game_stats[:home_team][:goals]
      else
        game.teams_game_stats[:away_team][:goals]
      end
    end
  end

  def most_goals_scored
    home_and_away_goals.max
  end

  def fewest_goals_scored
    home_and_away_goals.min
  end

  def self.generate_teams(team_csv)
    teams_hash = {}
    team_csv.each do |team|
      teams_hash[team[:team_id]] = Team.new(team)
    end
    teams_hash
  end

end
