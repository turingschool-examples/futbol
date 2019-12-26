require_relative "season"
require_relative "game"

class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link,
              :away_games,
              :home_games

  def initialize(team_info)
    @team_id = team_info[:team_id].to_i
    @franchise_id = team_info[:franchiseid].to_i
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
    @away_games = away_games_getter
    @home_games = home_games_getter
  end

  def team_info
    team_info = {team_id: @team_id,
      franchise_id: @franchise_id,
      team_name: @team_name,
      abbreviation: @abbreviation,
      link: @link}
  end

  def away_games_getter
    Game.all.find_all { |game| game.away_team_id == @team_id }
  end

  def home_games_getter
    Game.all.find_all { |game| game.home_team_id == @team_id }
  end

  def average_goals_away
    away_scores = @away_games.map { |game| game.away_goals }
    (away_scores.sum.to_f / @away_games.length.to_f).round(3)
  end

  def average_goals_home
    home_scores = @home_games.map { |game| game.home_goals }
    (home_scores.sum.to_f / @home_games.length.to_f).round(2)
  end

  def average_goals_total
    (average_goals_away + average_goals_home / 2).round(3)
  end

  def stats_by_season
    stats_by_season = Hash.new {|hash, key| hash[key] = {}}
    Season.all.each do |season|
      games = season.games_unsorted.find_all do |game|
        (game.home_team_id == @team_id || game.away_team_id == @team_id)
      end
      wins = games.find_all {|game| game.winner == @team_id}
      stats_by_season[season.id] = {total_games: games.length,
                                    wins: wins.length,
                                    win_percentage: (wins.length.to_f / games.length).round(2)}
    end
    stats_by_season
  end

  def win_percent_total
    games_played = (@home_games + @away_games)
    won_games = games_played.find_all { |game| game.winner == @team_id }.length
    (won_games.to_f / games_played.length).round(2)
  end

  def total_games_played
    @home_games.length + @away_games.length
  end

  def home_win_percentage
    home_wins = @home_games.find_all do |game|
      game.winner == @team_id
    end
    (home_wins.length.to_f / total_games_played).round(2)
  end

  def away_win_percentage
    away_wins = @away_games.find_all do |game|
      game.winner == @team_id
    end
    (away_wins.length.to_f / total_games_played).round(2)
  end

  def total_scores_against
    ((@away_games.sum(&:home_goals).to_f + @home_games.sum(&:away_goals)) / total_games_played).round(2)
  end

end
