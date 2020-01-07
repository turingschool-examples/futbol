require_relative "season"
require_relative "game"

class Team

  def self.from_csv(team_path)
		teams_storage = []
		CSV.foreach(team_path, :headers => true, header_converters: :symbol) do |row|
			teams_storage.push(Team.new(row))
		end
		teams_storage
  end

  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link,
              :away_games,
              :home_games,
              :stats_by_season

  def initialize(team_info)
    @team_id = team_info[:team_id].to_i
    @franchise_id = team_info[:franchiseid].to_i
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
    @away_games = away_games_getter
    @home_games = home_games_getter
    @stats_by_season = stats_grabber
  end

  def team_info
    {"team_id" => @team_id.to_s,
    "franchise_id" => @franchise_id.to_s,
    "team_name" => @team_name,
    "abbreviation" => @abbreviation,
    "link" => @link}
  end

  def away_games_getter
    Game.all.find_all { |game| game.away_team_id == @team_id }
  end

  def home_games_getter
    Game.all.find_all { |game| game.home_team_id == @team_id }
  end

  def average_goals_away
    away_scores = away_games.map { |game| game.away_goals }
    (away_scores.sum.to_f / away_games.length.to_f).round(2)
  end


  def average_goals_home
    home_scores = home_games.map { |game| game.home_goals }
    (home_scores.sum.to_f / home_games.length.to_f).round(2)
  end

  def average_goals_total
    ((average_goals_away + average_goals_home) / 2).round(2)
  end

  def stats_grabber
    stats = Hash.new {|hash, key| hash[key] = Hash.new(0)}
    Season.all.each do |season|
      games_reg = season.games_by_type["Regular Season"].find_all {|game| team_id == game.home_team_id || team_id == game.away_team_id}
      games_post = season.games_by_type["Postseason"].find_all {|game| team_id == game.home_team_id || team_id == game.away_team_id}
      stats[season.id.to_s] = {:regular_season => {win_percentage: calc_win_percent(games_reg),
                                              total_goals_scored: goals_scored(games_reg),
                                              total_goals_against: goals_against(games_reg),
                                              average_goals_scored: goals_scored_ave(games_reg),
                                              average_goals_against: goals_against_ave(games_reg)}}
      stats[season.id.to_s].merge!({:postseason => {win_percentage: calc_win_percent(games_post),
                                              total_goals_scored: goals_scored(games_post),
                                              total_goals_against: goals_against(games_post),
                                              average_goals_scored: goals_scored_ave(games_post),
                                              average_goals_against: goals_against_ave(games_post)}})
    end
    stats
  end

  def calc_win_percent(collection)
    return 0.0 if collection.length == 0
    (collection.find_all {|game| game.winner == team_id}.length.to_f / collection.length).round(2)
  end

  def goals_against_ave(collection)
    return 0.0 if collection.length == 0
    away_goals_against = collection.find_all {|game| game.home_team_id == team_id}
    home_goals_against = collection.find_all {|game| game.away_team_id == team_id}
    ((away_goals_against.sum(&:away_goals).to_f + home_goals_against.sum(&:home_goals)) / collection.length).round(2)
  end

  def goals_against(collection)
    return 0.0 if collection.length == 0
    away_goals_against = collection.find_all {|game| game.home_team_id == team_id}
    home_goals_against = collection.find_all {|game| game.away_team_id == team_id}
    ((away_goals_against.sum(&:away_goals).to_f + home_goals_against.sum(&:home_goals)))
  end

  def goals_scored_ave(collection)
    return 0.0 if collection.length == 0
    away_goals = collection.find_all {|game| game.home_team_id == team_id}
    home_goals = collection.find_all {|game| game.away_team_id == team_id}
    ((away_goals.sum(&:home_goals).to_f + home_goals.sum(&:away_goals)) / collection.length).round(2)
  end

  def goals_scored(collection)
    return 0.0 if collection.length == 0
    away_goals = collection.find_all {|game| game.home_team_id == team_id}
    home_goals = collection.find_all {|game| game.away_team_id == team_id}
    ((away_goals.sum(&:home_goals).to_f + home_goals.sum(&:away_goals)))
  end

  def win_percent_total
    games_played = (home_games + away_games)
    won_games = games_played.find_all { |game| game.winner == @team_id }.length
    (won_games.to_f / games_played.length).round(2)
  end

  def total_games_played
    home_games.length + away_games.length
  end

  def home_win_percentage
    home_wins = home_games.find_all do |game|
      game.winner == @team_id
    end
    (home_wins.length.to_f / total_games_played).round(2)
  end

  def away_win_percentage
    away_wins = away_games.find_all do |game|
      game.winner == @team_id
    end
    (away_wins.length.to_f / total_games_played).round(2)
  end

  def total_scores_against
    ((away_games.sum(&:home_goals).to_f + home_games.sum(&:away_goals)) / total_games_played).round(2)
  end

  def total_winning_percentage
    all_games_won = all_games_played.find_all do |game|
      game.winner == @team_id
    end
    (all_games_won.length.to_f / all_games_played.length).round(2)
  end

  def all_games_played
    home_games + away_games
  end

end
