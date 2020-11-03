require_relative './game_team'
require_relative './calculator'

class GameTeamsCollection
  include Calculator

  attr_reader :game_teams
  def initialize(game_teams_path, parent)
    @parent = parent
    @game_teams = []
    create_game_teams(game_teams_path)
  end

  def create_game_teams(game_teams_path)
    CSV.foreach(game_teams_path, headers: true, header_converters: :symbol) do |row|
      @game_teams << GameTeam.new(row)
    end
  end

  def find_team_name(id)
    @parent.find_team_name(id)
  end

  def games_by_team
    games_by_hoa
  end

  def away_games_by_team
    games_by_hoa("away")
  end

  def home_games_by_team
    games_by_hoa("home")
  end

  def games_by_hoa(hoa = "all")
    game_teams.each_with_object(Hash.new(0)) do |game_team, average|
      if game_team.hoa == hoa
        average[game_team.team_id] += 1
      elsif hoa == "all"
        average[game_team.team_id] += 1
      end
    end
  end

  def goal_total_by_hoa(hoa = "all")
    game_teams.each_with_object(Hash.new(0)) do |game_team, average|
      if game_team.hoa == hoa
        average[game_team.team_id] += game_team.goals
      elsif hoa == "all"
        average[game_team.team_id] += game_team.goals
      end
    end
  end

  def average_goals_by_team
    combine(games_by_team, goal_total_by_hoa)
  end

  def average_away_goals_by_team
    combine(away_games_by_team, goal_total_by_hoa("away"))
  end

  def average_home_goals_by_team
    combine(home_games_by_team, goal_total_by_hoa("home"))
  end

  def best_offense
    high(average_goals_by_team).first
  end

  def worst_offense
    low(average_goals_by_team).first
  end

  def highest_scoring_visitor
    highest_goals = average_away_goals_by_team.max_by do |goals|
      goals[-1]
    end
    find_team_name(highest_goals[0])
  end

  def highest_scoring_hometeam
    highest_goals = average_home_goals_by_team.max_by do |goals|
      goals[-1]
    end
    find_team_name(highest_goals[0])
  end

  def lowest_scoring_visitor
    lowest_goals = average_away_goals_by_team.min_by do |goals|
      goals[-1]
    end
    find_team_name(lowest_goals[0])
  end

  def lowest_scoring_hometeam
    lowest_goals = average_home_goals_by_team.min_by do |goals|
      goals[-1]
    end
    find_team_name(lowest_goals[0])
  end

  def seasons(id)
    @parent.find_season_id(id)
  end

  def wins_by_coach(season_id)
    game_id = seasons(season_id)
    coaches_by_season = Hash.new {|h, k| h[k] = []}
    game_teams.each do |game_team|
      if game_id.include?(game_team.game_id)
        coaches_by_season[game_team.head_coach] << game_team.result
      end
    end
    rehash = Hash.new {|h, k| h[k] = {win: 0, loss: 0, tie: 0}}
    wins = coaches_by_season.each do |coaches, result|
        result.each do |status|
          if status == "WIN"
            rehash[coaches][:win] += 1
          elsif status == "LOSS"
            rehash[coaches][:loss] += 1
          elsif status == "TIE"
            rehash[coaches][:tie] += 1
          end
        end
    end
    rehash
  end

  def winningest_coach(season_id)
    wins = wins_by_coach(season_id).max_by do |coach, totals|
      totals[:win].to_f / (totals[:win] + totals[:loss] + totals[:tie])
    end
    wins.first
  end

  def worst_coach(season_id)
    wins = wins_by_coach(season_id).min_by do |coach, totals|
      totals[:win].to_f / (totals[:win] + totals[:loss] + totals[:tie])
    end
    wins.first
  end

  def shots_by_team_by_season(season_id)
    game_ids = seasons(season_id)
    games_by_season = Hash.new {|h, k| h[k] = {shots: 0, goals: 0}}
    game_teams.each do |game_team|
      if game_ids.include?(game_team.game_id)
        games_by_season[game_team.team_id][:shots] += game_team.shots
        games_by_season[game_team.team_id][:goals] += game_team.goals
      end
    end
    games_by_season
  end

  def most_accurate_team(season_id)
    accurate = shots_by_team_by_season(season_id).min_by do |team, scores|
      (scores[:shots].to_f / scores[:goals])
    end
    find_team_name(accurate.first)
  end

  def least_accurate_team(season_id)
    accurate = shots_by_team_by_season(season_id).max_by do |team, scores|
      (scores[:shots].to_f / scores[:goals])
    end
    find_team_name(accurate.first)
  end

  def teams_with_tackles(season_id)
    game_ids = seasons(season_id)
    team_with_tackles = Hash.new(0)
    game_teams.each do |game_team|
      if game_ids.include?(game_team.game_id)
        team_with_tackles[game_team.team_id] += game_team.tackles
      end
    end
    team_with_tackles
  end

  def most_tackles(season_id)
    most = teams_with_tackles(season_id).max_by do |team, tackles|
      tackles
    end
    find_team_name(most.first)
  end

  def fewest_tackles(season_id)
    least = teams_with_tackles(season_id).min_by do |team, tackles|
      tackles
    end
    find_team_name(least.first)
  end
end
