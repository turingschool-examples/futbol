require_relative './statistics'
class TeamStatistics < Statistics

  attr_reader :game_collection, :game_teams_collection, :teams_collection
  # def initialize(game_collection, game_teams_collection, teams_collection)
  #   @game_collection = game_collection
  #   @game_teams_collection = game_teams_collection
  #   @teams_collection = teams_collection
  # end

  def team_info(team_id)
    # A hash with key/value pairs for the following attributes: team_id, franchise_id, team_name, abbreviation, and link

    team = @teams_collection.find{ |team| team.id == team_id}
    team_info = {"team_id" => team.id,
                 "franchise_id" => team.franchise_id,
                 "team_name" => team.team_name,
                 "abbreviation" => team.abbreviation,
                 "link" => team.link}
  end

  def games_played(team_id)
    # This method can probably be combined in a module with games_played_by_team in league statistics
    @game_collection.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
  end

  def season_best_and_worst(team_id, best_or_worst)
    games_played_in = games_played(team_id)
    games_by_season = games_played_in.group_by {|game| game.season}

    win_percentage_by_season = games_by_season.transform_values do |season|
      games_won = count_wins(team_id, season)
      (games_won/season.length.to_f).round(2)
    end

    if best_or_worst == "best"
      best_season = win_percentage_by_season.max_by { |season| season[1]}
      best_season[0]
    elsif best_or_worst == "worst"
      worst_season = win_percentage_by_season.min_by { |season| season[1]}
      worst_season[0]
    end
  end

  def average_win_percentage(team_id)
    games_played_in = @game_teams_collection.find_all do |game|
      team_id == game.team_id
    end
    games_won = games_played_in.find_all { |game| game.result == "WIN"}

    (games_won.length.to_f / games_played_in.length).round(2)
  end

def goals_scored_high_and_low(team_id, high_or_low)
  games_played_in = @game_teams_collection.find_all do |game|
    team_id == game.team_id
  end

  highest_scoring_game = games_played_in.max_by {|game| game.goals}
  lowest_scoring_game = games_played_in.min_by {|game| game.goals}

  if high_or_low == "high"
    highest_scoring_game.goals
  elsif high_or_low == "low"
    lowest_scoring_game.goals
  end
end

  def games_by_opponent_team_id(team_id)
    games_played_in = games_played(team_id)
    games_by_opponent_id = Hash.new { |h, k| h[k] = [] }

    games_played_in.each do |game|
      games_by_opponent_id[game.away_team_id] << game
      games_by_opponent_id[game.home_team_id] << game
    end
    games_by_opponent_id.delete(team_id)
    games_by_opponent_id
  end

  def count_wins(team_id, games_played)
    wins = 0
    games_played.each do |game|
      if team_id == game.away_team_id && game.away_goals > game.home_goals
        wins += 1
      elsif team_id == game.home_team_id && game.home_goals > game.away_goals
        wins += 1
      end
    end
    wins
  end

  def games_won_by_opponent(team_id)
    games_by_opponent_id = games_by_opponent_team_id(team_id)

    games_by_opponent_id.transform_values do |games_played_against_opponent|
      games_won = count_wins(team_id, games_played_against_opponent)
      games_played = games_played_against_opponent.length
      [games_won,games_played]
    end
  end

  def win_percentage_against_opponent(team_id)
    games_won_by_opponent(team_id).transform_values do |opponent|
      # opponent[0] -> games won, opponent[1] -> games played
      opponent[0].to_f/opponent[1]
    end
  end

  def opponent_preference(team_id, high_or_low)
    win_percentage_by_opponent = win_percentage_against_opponent(team_id)
    if high_or_low == "fav"
      # fav_opponent [0] -> team_id, [1] -> win percentage
      fav_opponent = win_percentage_by_opponent.max_by {|opponent| opponent[1]}
      team_info(fav_opponent[0])["team_name"]
    elsif high_or_low == "rival"
      # rival [0] -> team_id, [1] -> win percentage
      rival = win_percentage_by_opponent.min_by {|opponent| opponent[1]}
      team_info(rival[0])["team_name"]
    end
  end

end
