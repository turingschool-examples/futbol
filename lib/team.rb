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
    #alex review
    away_games = Game.all.find_all do |game|
       game.away_team_id == @team_id
     end
     away_scores = away_games.map do |game|
       game.away_goals
     end
     (away_scores.sum.to_f / away_games.length.to_f).round(2)
    end

    def average_goals_home
      home_games = Game.all.find_all do |game|
        game.home_team_id == @team_id
      end
      home_scores = home_games.map do |game|
        game.home_goals
      end
      (home_scores.sum.to_f / home_games.length.to_f).round(2)
    end

  # def stats_by_season
  #   stats_by_season = Hash.new {|hash, key| hash[key] = {}}
  #   Season.all.each do |season|
  #     games = season.games_unsorted.find_all do |game|
  #       (game.home_team_id == @team_id || game.away_team_id == @team_id)
  #     end
  #     wins = games.find_all {|game| game.winner == @team_id}
  #     stats_by_season[season.id] = {total_games: games.length,
  #                                   wins: wins.length,
  #                                   win_percentage: (wins.length / games.length).to_f * 100}
  #   end
  #   stats_by_season
  # end

  def total_winning_percentage
    all_games_played = Game.all.find_all do |game|
      game.home_team_id == @team_id || game.away_team_id == @team_id
    end
    all_games_won = all_games_played.find_all do |game|
      game.winner == @team_id
    end
    (all_games_won.length.to_f / all_games_played.length).round(2)
  end
end
