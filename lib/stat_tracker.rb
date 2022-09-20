require 'csv'
require 'pry'
class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data

  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @league = League.new(@teams_data, @game_teams_data)
    @game = Game.new(@games_data)
    @team = Team.new(@teams_data, @game_teams_data, @games_data)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def total_game_goals
    @game.total_game_goals
  end

  def highest_total_score
    @game.highest_total_score
  end

  def lowest_total_score
    @game.lowest_total_score
  end

  def percentage_home_wins
    @game.percentage_home_wins
  end

  def percentage_visitor_wins
    @game.percentage_visitor_wins
  end

  def percentage_ties
    @game.percentage_ties
  end

  def count_of_games_by_season
    @game.count_of_games_by_season
  end

  def count_of_goals_by_season
    @game.count_of_goals_by_season
  end

  def average_goals_per_game
    @game.average_goals_per_game
  end

  def average_goals_by_season
    @game.average_goals_by_season
  end

  def count_of_games_by_season
    @game.count_of_games_by_season
  end

  def count_of_teams
    @league.count_of_teams
  end

  def best_offense
    @league.best_offense
  end

  def worst_offense
    @league.worst_offense
  end

  def highest_scoring_visitor
    @league.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league.lowest_scoring_home_team
  end

  # team class

  def winningest_coach(campaign)
    coached_games_in_season = Hash.new(0)
    coach_wins_in_season = Hash.new(0)
    game_results_percentage = {}

    season_data(campaign).find_all do |row|
      coach_wins_in_season [row[:head_coach]] += 1 if row[:result] == 'WIN'
    end
    coach_wins_in_season

    season_data(campaign).find_all do |row|
      coached_games_in_season[row[:head_coach]] += 1 if coach_wins_in_season.has_key?(row[:head_coach])
    end
    coached_games_in_season

    game_results_percentage.update(coached_games_in_season, coach_wins_in_season) do |_coach, games_coached, games_won|
      games_won.fdiv(games_coached).round(4)
    end
    winning_coach = game_results_percentage.max_by { |_coach, percentage| percentage }

    winning_coach[0]
  end

  def worst_coach(campaign)
    coached_games_in_season = Hash.new(0)
    coach_wins_in_season = Hash.new(0)
    game_results_percentage = {}

    season_data(campaign).select do |row|
      coach_wins_in_season [row[:head_coach]] += 1 if row[:result] != 'WIN'
    end
    coach_wins_in_season

    season_data(campaign).select { |row| coached_games_in_season[row[:head_coach]] += 1 }
    coached_games_in_season

    game_results_percentage.update(coached_games_in_season, coach_wins_in_season) do |_coach, games_coached, games_won|
      games_won.fdiv(games_coached).round(4)
    end
    worst_coach = game_results_percentage.max_by { |_coach, percentage| percentage }

    worst_coach[0]
  end

  def most_accurate_team(campaign)
    team_season_goals_count = Hash.new(0)
    team_season_shots_count = Hash.new(0)
    shot_efficiency = {}

    season_data(campaign).find_all do |row|
      goals = row[:goals].to_i
      shots = row[:shots].to_i

      team_season_goals_count[row[:team_id]] += goals
      team_season_shots_count[row[:team_id]] += shots
    end
    team_season_goals_count
    team_season_shots_count

    shot_efficiency.update(team_season_goals_count, team_season_shots_count) do |_team, goals_made, shots_taken|
      goals_made.fdiv(shots_taken).round(4)
    end
    team_efficiency = shot_efficiency.max_by { |_coach, percentage| percentage }

    team_name_from_id_average(team_efficiency)
  end

  def least_accurate_team	(campaign)
    team_season_goals_count = Hash.new(0)
    team_season_shots_count = Hash.new(0)
    shot_efficiency = {}

    season_data(campaign).each do |row|
      goals = row[:goals].to_i
      shots = row[:shots].to_i

      team_season_goals_count[row[:team_id]] += goals
      team_season_shots_count[row[:team_id]] += shots
    end
    team_season_goals_count
    team_season_shots_count

    shot_efficiency.update(team_season_goals_count, team_season_shots_count) do |_team, goals_made, shots_taken|
      goals_made.fdiv(shots_taken).round(4)
    end
    team_efficiency = shot_efficiency.min_by { |_coach, percentage| percentage }

    team_name_from_id_average(team_efficiency)
  end

  def most_tackles(campaign)
    team_total_tackles = Hash.new(0)
    season_data(campaign)

    season_data(campaign).each do |row|
      tackles = row[:tackles].to_i
      team_total_tackles[row[:team_id]] += tackles
    end
    number_of_team_tackle = team_total_tackles.max_by { |_coach, percentage| percentage }

    team_name_from_id_average(number_of_team_tackle)
  end

  def fewest_tackles(campaign)
    team_total_tackles = Hash.new(0)
    season_data(campaign)

    season_data(campaign).each do |row|
      tackles = row[:tackles].to_i
      team_total_tackles[row[:team_id]] += tackles
    end
    team_tackle = team_total_tackles.min_by { |_coach, percentage| percentage }
    team_name_from_id_average(team_tackle)
  end

  def team_name_from_id_average(data)
    @teams_data.each do |row|
      return row[:teamname] if data[0] == row[:team_id]
    end
  end

  def season_data(campaign)
    season = Set.new
    @game_teams_data.each do |row|
      row.find_all do |_game_id|
        season << row if campaign.scan(/.{4}/).shift == row[:game_id].scan(/.{4}/).shift
      end
    end
    season
  end

  # Method returns best season for each team
  def best_season(team)
    campaign = @games_data.map { |row| row[:season] }.uniq

    hash = Hash.new do |h, k|
      h[k] = { games_won: 0, games_played: 0 }
    end

    campaign.each do |year|
      a = @games_data.find_all do |row|
        row[:season] == year &&
          (row[:away_team_id] == team || row[:home_team_id] == team)
      end

      a.each do |game_row|
        b = @game_teams_data.find do |game_team_row|
          game_team_row[:game_id] == game_row[:game_id] && game_team_row[:team_id] == team
        end
        hash[year][:games_won] += 1 if b[:result] == 'WIN'
        hash[year][:games_played] += 1
      end
    end

    season_average_percentage = {}

    hash.each do |year, totals|
      season_average_percentage[year] = (totals[:games_won].to_f / totals[:games_played]).round(4)
    end

    season_record = season_average_percentage.max_by { |_year, percentage| percentage }
    season_record[0]
    # require 'pry';binding.pry
  end

  # Method returns best season for each team
  def worst_season(team)
    campaign = @games_data.map { |row| row[:season] }.uniq

    hash = Hash.new do |h, k|
      h[k] = { games_won: 0, games_played: 0 }
    end

    campaign.each do |year|
      a = @games_data.find_all do |row|
        row[:season] == year &&
          (row[:away_team_id] == team || row[:home_team_id] == team)
      end

      a.each do |game_row|
        b = @game_teams_data.find do |game_team_row|
          game_team_row[:game_id] == game_row[:game_id] && game_team_row[:team_id] == team
        end
        hash[year][:games_won] += 1 if b[:result] == 'WIN'
        hash[year][:games_played] += 1
      end
    end

    season_average_percentage = {}

    hash.each do |year, totals|
      season_average_percentage[year] = (totals[:games_won].to_f / totals[:games_played]).round(4)
    end

    season_record = season_average_percentage.min_by { |_year, percentage| percentage }
    season_record[0]
  end

  def team_info
    @team.team_info
  end

  def average_win_percentage
    @team.average_win_percentage
  end

  def most_goals_scored
    @team.most_goals_scored
  end

  def fewest_goals_scored
    @team.fewest_goals_scored
  end

  def favorite_opponent
    @team.favorite_opponent
  end

  def rival
    @team.rival
  end
end
