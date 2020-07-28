require_relative '../lib/game'

class GameManager

  attr_reader :games_array

  def initialize(game_path)
    @games_array = []
    CSV.foreach(game_path, headers: true) do |row|
      @games_array << Game.new(row)
    end
  end

  def highest_total_score
    @all_goals_max = []
    @games_array.each do |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_max << total_goals
    end
    @all_goals_max.max
  end

  def lowest_total_score
    @all_goals_min = []
    @games_array.each do |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_min << total_goals
    end
    @all_goals_min.min
  end

  def create_games_by_season_array
    games_by_season = {}
    @games_array.each do |game|
      games_by_season[game.season] = []
    end
    @games_array.each do |game|
      games_by_season[game.season]<< game.game_id
    end
    games_by_season
  end

  def count_of_games_by_season(games_by_season)
    games_by_season.each { |k, v| games_by_season[k] = v.count}
  end

  def collect_all_goals
    total_goals = []
    @games_array.each do |game|
      total_goals << game.away_goals.to_i
      total_goals << game.home_goals.to_i
    end
    total_goals
  end

  def average_goals_per_game(total_goals)
    (total_goals.sum.to_f/(total_goals.size/2)).round(2)
  end

  def collect_goals_by_season
    season_goals = Hash.new { |hash, key| hash[key] = [] }
    @games_array.each do |game|
      season_goals[game.season] = []
      season_goals[game.season] = []
    end
    @games_array.each do |game|
      season_goals[game.season] << game.home_goals.to_i
      season_goals[game.season] << game.away_goals.to_i
    end
    season_goals
  end

  def average_goals_by_season(season_goals)
    season_goals.keys.each do |season|
      season_goals[season] = (season_goals[season].sum.to_f/(season_goals[season].size)*2).round(2)
    end
    season_goals
  end

  def best_season(id)
    @all_games = @games_array.select do |row|
      row.away_team_id == "#{id}" || row.home_team_id == "#{id}"
    end
    @away_wins = @all_games.select do |row|
      row.away_team_id == "#{id}" && row.away_goals > row.home_goals
    end
    @home_wins = @all_games.select do |row|
      row.home_team_id == "#{id}" && row.away_goals < row.home_goals
    end
    @seasons = (@away_wins + @home_wins).map do |x| x.season
    end
    freq = @seasons.inject(Hash.new(0)) do |h,v| h[v] += 1; h
    end
    @seasons.max_by { |v| freq[v] }
  end

  def worst_season(id)
    self.best_season(id)
    freq = @seasons.inject(Hash.new(0)) do |h,v|
      h[v] += 1; h
    end
    @seasons.min_by do |v| freq[v]
    end
  end

  def average_win_percentage(id)
    @all_games = @games_array.select do |row|
      row.away_team_id == "#{id}" || row.home_team_id == "#{id}"
    end
    @away_wins = @all_games.select do |row|
      row.away_team_id == "#{id}" && row.away_goals > row.home_goals
    end
    @home_wins = @all_games.select do |row|
      row.home_team_id == "#{id}" && row.away_goals < row.home_goals
    end
    @all_wins = (@away_wins + @home_wins)
    (@all_wins.length.to_f/@all_games.length.to_f).round(2)
  end

  def most_goals_scored(id)
    self.average_win_percentage(id)
    @away = @away_wins.map do |game|
      game.away_goals
    end
    @home = @home_wins.map do |game|
      game.home_goals
    end
    (@away + @home).sort[-1].to_i
  end

  def fewest_goals_scored(id)
    self.average_win_percentage(id)
    @all_games = @games_array.select do |row|
      row.away_team_id == "#{id}" || row.home_team_id == "#{id}"
    end
    goals = []
    @all_games.each do |game|
      if game.home_team_id == "#{id}"
        goals << game.home_goals
      elsif game.away_team_id == "#{id}"
        goals << game.away_goals
      end
    end
    goals.min.to_i
  end

  def favorite_opponent(id)
   self.best_season(id)
   teams = []
   @all_games.select do |rows|
     if rows.home_team_id == "#{id}"
       if rows.away_goals > rows.home_goals
         teams << rows.away_team_id
       end
     elsif rows.away_team_id == "#{id}"
       if rows.away_goals == rows.home_goals
         teams << rows.home_team_id
       end
     end
   end
   freq = teams.inject(Hash.new(0)) do |h,v| h[v] += 1; h
   end
   @numbs = teams.min_by do |v| freq[v]
   end
 end

 def rival(id)
   teams = []
   self.best_season(id)
   @all_games.each do |game|
     if game.away_team_id == "#{id}"
       teams << game.home_team_id
     elsif game.home_team_id == "#{id}"
       teams << game.away_team_id
     end
   end
   teams
   games_played_against = teams.inject(Hash.new(0)) do |h,v| h[v] += 1; h
   end
   teams1 = []
   @all_games.each do |game|
     if game.away_team_id == "#{id}"
       if game.away_goals < game.home_goals
         teams1 << game.home_team_id
       end
     elsif game.home_team_id == "#{id}"
       if game.away_goals > game.home_goals
         teams1 << game.away_team_id
       end
     end
   end
     teams1
     games_won_against = teams1.inject(Hash.new(0)) do |h,v| h[v] += 1; h
     end
     hash1 = games_won_against.merge(games_played_against)do
     |k, a_value, b_value| a_value .to_f / b_value.to_f
   end
     hash1.delete("14")
     team_final = hash1.max_by{|k,v| v}[0]
 end

 def games_by_season(season)
   @games_array.select do |game|
    game.season == season
  end.map do |game| game.game_id
      end
 end

end
