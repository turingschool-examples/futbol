require 'csv'

class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data

  def initialize(games_data, teams_data, game_teams_data)
    @games_data = games_data
    @teams_data = teams_data
    @game_teams_data = game_teams_data
  end

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    games_data = CSV.read game_path, headers:true
    teams_data = CSV.read team_path, headers:true
    game_teams_data = CSV.read game_teams_path, headers:true
    StatTracker.new(games_data, teams_data, game_teams_data)
  end

  # def test
  #   @games_data.map do|row|
  #     row["game_id"]
  #   end
  # end

  def total_home_wins 
    @games_data.count { |row| row["home_goals"].to_i > row["away_goals"].to_i }
  end

  def total_away_wins
    @games_data.count { |row| row["away_goals"].to_i > row["home_goals"].to_i }
  end

  def total_ties
    @games_data.count { |row| row["away_goals"].to_i == row["home_goals"].to_i }
  end

  def total_games
    @games_data.count
  end

  def percentage_home_wins
    (total_home_wins / total_games.to_f).round(2)
  end

  def percentage_visitor_wins
    (total_away_wins / total_games.to_f).round(2)
  end

  def percentage_ties
    (total_ties / total_games.to_f).round(2)
  end

  def winningest_coach(season_id)
    sorted_wins_by_coach(season_id)[0][0]
  end

  def worst_coach(season_id)
    sorted_wins_by_coach(season_id)[-1][0]
  end

  def games_by_season
    games_by_season = Hash.new(0)
    @games.each do |row|
      if games_by_season.keys.include?(row["season"])
        games_by_season[row["season"]] << row["game_id"]
      else 
        games_by_season[row["season"]] = [row["game_id"]]
      end 
    end
    games_by_season
  end

  def sorted_wins_by_coach(season_id) 
    wins_by_coach = Hash.new(0)
    @game_teams_data.each do |row|
      row["head_coach"].each do |coach|
        wins_by_coach[coach] += 1 if row["result"] == "WIN"
      end
    end
    wins_by_coach.sort_by { |coach, wins| wins }.reverse
  end
end
