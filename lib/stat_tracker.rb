require_relative "./game"
require_relative "./team"
require_relative "./game_team"
require "CSV"
class StatTracker
  def initialize()
  end

  def self.from_csv(locations)
    StatTracker.create_items(locations[:games], Game)
    StatTracker.create_items(locations[:game_teams], GameTeam)
    StatTracker.create_items(locations[:teams], Team)
    StatTracker.new()
  end

  def self.create_items(file, item_class)
    csv_options = {
                    headers: true,
                    header_converters: :symbol,
                    converters: :all
                  }
      CSV.foreach(file, csv_options) { |row| item_class.add(item_class.new(row.to_hash)) }
  end

  def count_of_teams
    Team.all.count
  end

  def best_offense
    teams = change_data_to_array(Team)
    best_team = teams.max_by do |team|
      games_with_team = games_played_by_team(team)
      if !games_with_team.empty?
        total_score = games_with_team.sum do |game|
          game.home_team_id == team.team_id ? game.home_goals : game.away_goals
        end
        total_score.to_f / games_with_team.count
      end
    end
    best_team.team_name
  end

  def worst_offense
    teams = change_data_to_array(Team)
    worst_team = teams.min_by do |team|
      games_with_team = games_played_by_team(team)
      if !games_with_team.empty?
        total_score = games_with_team.sum do |game|
          game.home_team_id == team.team_id ? game.home_goals : game.away_goals
      end
        total_score.to_f / games_with_team.count
      end
    end
    worst_team.team_name
  end

  def best_defense
    teams = change_data_to_array(Team)
    best_team = teams.min_by do |team|
      games_with_team = games_played_by_team(team)
      if !games_with_team.empty?
        total_score = games_with_team.sum do |game|
          game.home_team_id == team.team_id ? game.away_goals : game.home_goals
      end
        total_score.to_f / games_with_team.count
      end
    end
    best_team.team_name
  end

  def worst_defense
    teams = change_data_to_array(Team)
    worst_team = teams.max_by do |team|
      games_with_team = games_played_by_team(team)
      if !games_with_team.empty?
        total_score = games_with_team.sum do |game|
          game.home_team_id == team.team_id ? game.away_goals : game.home_goals
      end
        total_score.to_f / games_with_team.count
      end
    end
    worst_team.team_name
  end

  def highest_scoring_visitor
    teams = change_data_to_array(Team)
    games = change_data_to_array(Game)
    highest_visitor = teams.max_by do |team|
      games_visiting = games.select { |game| game.away_team_id == team.team_id }
      total_score = games_visiting.sum { |game| game.away_goals }
      total_score.to_f / games_visiting.count
    end
    highest_visitor.team_name
  end

  def lowest_scoring_visitor
    teams = change_data_to_array(Team)
    games = change_data_to_array(Game)
    highest_visitor = teams.min_by do |team|
      games_visiting = games.select { |game| game.away_team_id == team.team_id }
      total_score = games_visiting.sum { |game| game.away_goals }
      total_score.to_f / games_visiting.count
    end
    highest_visitor.team_name
  end

  def highest_scoring_home_team
    teams = change_data_to_array(Team)
    games = change_data_to_array(Game)
    highest_home = teams.max_by do |team|
      games_visiting = games.select { |game| game.home_team_id == team.team_id }
      total_score = games_visiting.sum { |game| game.home_goals }
      total_score.to_f / games_visiting.count
    end
    highest_home.team_name
  end

  def lowest_scoring_home_team
    teams = change_data_to_array(Team)
    games = change_data_to_array(Game)
    lowest_home = teams.min_by do |team|
      games_visiting = games.select { |game| game.home_team_id == team.team_id }
      total_score = games_visiting.sum { |game| game.home_goals }
      total_score.to_f / games_visiting.count
    end
    lowest_home.team_name
  end

  def winningest_team
    teams = change_data_to_array(Team)
    winningest = teams.max_by do |team|
      games_with_team = games_played_by_team(team)
      if !games_with_team.empty?
        games_won = games_with_team.count do |game|
          if game.home_team_id == team.team_id
            game.home_goals > game.away_goals
          else
            game.away_goals > game.home_goals
          end
        end
      end
      games_won.to_f / games_with_team.count
    end
    winningest.team_name
  end

  def best_fans
    teams = change_data_to_array(Team)
    biggest_home_away_diff = teams.max_by do |team|
      games_with_team = games_played_by_team(team)
      if !games_with_team.empty?
        home_games, away_games = games_with_team.partition do |game|
          game.home_team_id == team.team_id
        end
        home_win_percentage = win_percentage(home_games, team)
        away_win_percentage = win_percentage(away_games, team)
        (home_win_percentage - away_win_percentage).abs
      end

    end
    biggest_home_away_diff.team_name
  end

  def worst_fans
    teams = change_data_to_array(Team)
    teams_with_better_away = teams.select do |team|
      games_with_team = games_played_by_team(team)
      home_games, away_games = games_with_team.partition do |game|
        game.home_team_id == team.team_id
      end
      home_win_percentage = win_percentage(home_games, team)
      away_win_percentage = win_percentage(away_games, team)
      away_win_percentage > home_win_percentage
    end
    teams_with_better_away.map { |team| team.team_name }
  end

  def win_percentage(games, team)
    total_score = games.sum do |game|
      if game.home_team_id == team.team_id
        game.home_goals > game.away_goals ? 1 : 0
      elsif game.away_team_id == team.team_id
        game.away_goals > game.home_goals ? 1 : 0
      end
    end
    total_score.to_f / games.count
  end

  def change_data_to_array(data_class)
    data_class.all.values
  end

  def games_played_by_team(team)
    Game.all.values.select do |game|
      game.home_team_id == team.team_id || game.away_team_id == team.team_id
    end
  end

end
