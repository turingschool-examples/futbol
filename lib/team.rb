require_relative "season"
require_relative "game"

class Team
  attr_reader :team_id,
  :franchise_id,
  :team_name,
  :abbreviation,
  :stadium,
  :link

  def initialize(team_info)
    @team_id = team_info[:team_id].to_i
    @franchise_id = team_info[:franchiseid].to_i
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
  end

  def team_info
    team_info = {team_id: @team_id,
      franchise_id: @franchise_id,
      team_name: @team_name,
      abbreviation: @abbreviation,
      link: @link}
    team_info
  end

  def average_goals_away
    away_games = Game.all.find_all { |game| game.away_team_id == @team_id }
    away_scores = away_games.map { |game| game.away_goals }
    (away_scores.sum.to_f / away_games.length.to_f).round(2)
  end

  def average_goals_home
    home_games = Game.all.find_all { |game| game.home_team_id == @team_id }
    home_scores = home_games.map { |game| game.home_goals }
    (home_scores.sum.to_f / home_games.length.to_f).round(2)
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

end
