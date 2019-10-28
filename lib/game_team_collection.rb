require_relative './game_team'
require 'CSV'

class GameTeamCollection
  attr_reader :game_teams

  def initialize(csv_file_path)
    @game_teams = create_game_teams(csv_file_path)
  end

  def create_game_teams(csv_file_path)
    game_teams = []
    CSV.foreach("#{csv_file_path}", headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row)
    end
    game_teams
  end

  def count_of_teams
    team_id_array = @game_teams.map { |gt| gt.team_id }
    team_id_array.uniq.length
  end

  def home_games
     @game_teams.reduce({}) do |home_games, game_team|
      if home_games[game_team.team_id] && game_team.HoA == "home"
        home_games[game_team.team_id] += 1
      elsif game_team.HoA == "home"
        home_games[game_team.team_id] = 1
      end
      home_games
    end
  end

  def home_wins
    @game_teams.reduce({}) do |home_wins, game_team|
      if home_wins[game_team.team_id] && game_team.HoA == "home" && game_team.result == "WIN"
        home_wins[game_team.team_id] += 1
      elsif game_team.HoA == "home" && game_team.result == "WIN"
        home_wins[game_team.team_id] = 1
      elsif home_wins[game_team.team_id] && game_team.HoA == "home"  && game_team.result != "WIN"
        home_wins[game_team.team_id] += 0
      elsif game_team.HoA == "home" && game_team.result != "WIN"
        home_wins[game_team.team_id] = 0
      end
      home_wins
    end
  end

  def away_games
     @game_teams.reduce({}) do |away_games, game_team|
      if away_games[game_team.team_id] && game_team.HoA == "away"
        away_games[game_team.team_id] += 1
      elsif game_team.HoA == "away"
        away_games[game_team.team_id] = 1
      end
      away_games
    end
  end

  def away_wins
    @game_teams.reduce({}) do |away_wins, game_team|
      if away_wins[game_team.team_id] && game_team.HoA == "away" && game_team.result == "WIN"
        away_wins[game_team.team_id] += 1
      elsif game_team.HoA == "away" && game_team.result == "WIN"
        away_wins[game_team.team_id] = 1
      elsif away_wins[game_team.team_id] && game_team.HoA == "away"  && game_team.result != "WIN"
        away_wins[game_team.team_id] += 0
      elsif game_team.HoA == "away" && game_team.result != "WIN"
        away_wins[game_team.team_id] = 0
      end
      away_wins
    end
  end

  def home_win_percentage
    home_wins.merge(home_games) do |key, home_win_count, home_game_count|
      (home_win_count * 100).to_f / home_game_count
    end
  end

  def away_win_percentage
    away_wins.merge(away_games) do |key, away_win_count, away_game_count|
      (away_win_count * 100).to_f / away_game_count
    end
  end

  def best_fans

  end

  def worst_fans
    # team_ids_for_worst_fans = @game_teams.find_all do |team|
    #   team_away_wins > team_home_wins
    # end
  end
end
