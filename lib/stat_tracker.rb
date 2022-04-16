require 'CSV'
class StatTracker
  attr_reader :teams, :games, :game_teams

  def initialize(data1, data2, data3)
    @teams = data2
    @games = data1
    @game_teams = data3
  end

  def self.from_csv(locations)
    data = []
    locations.values.each do |location|
      contents = CSV.read "#{location}", headers: true, header_converters: :symbol
      data << contents
      end
      StatTracker.new(data[0], data[1], data[2])
  end

  def highest_total_score
    sum = []
    @games.each do |row|
      i = row[:away_goals].to_i + row[:home_goals].to_i
      sum << i
    end
    sum.max
  end

  def lowest_total_score
    sum = []
    @games.each do |row|
      i = row[:away_goals].to_i + row[:home_goals].to_i
      sum << i
    end
    sum.min
  end
































































#SAI
  def percentage_home_wins
    total_games = @games[:game_id].count.to_f
    home_wins = 0
    @games.each { |row| home_wins += 1 if row[:home_goals].to_i > row[:away_goals].to_i }
    decimal = (home_wins.to_f / total_games)
    (decimal * 100).round(2)
  end

  def percentage_visitor_wins
    total_games = @games[:game_id].count.to_f
    visitor_wins = 0
    @games.each { |row| visitor_wins += 1 if row[:home_goals].to_i < row[:away_goals].to_i }
    decimal = (visitor_wins.to_f / total_games)
    (decimal * 100).round(2)
  end

  def percentage_ties
    total_games = @games[:game_id].count.to_f
    number_tied = 0
    @games.each { |row| number_tied += 1 if row[:home_goals].to_i == row[:away_goals].to_i }
    decimal = (number_tied.to_f / total_games)
    (decimal * 100).round(2)
  end

  def games_by_season(season)
    games_in_season = @games.collect { |row| row[:game_id] if row[:season] == season}
    games_in_season.compact
  end

  def most_accurate_team(season_id) #returns a team name, with best ratio of shots and goals
    team_ratios = {}
    team_id_h = @game_teams.group_by { |row| row[:team_id].itself }
    team_id_h.each do |id, array|
      shots = 0.0
      goals = 0.0
      array.each do |row|
        if games_by_season(season_id).include?(row[:game_id])
          shots += row[:shots].to_f
          goals += row[:goals].to_f
        end
      end
      if goals != 0
        team_ratios["#{id}"] = (shots / goals).round(2)
      else
        team_ratios["#{id}"] = 0
      end
    end
    @teams.each do |row|
      if row[:team_id] == team_ratios.max_by{|k,v| v}[0]
        return row[:teamname]
      end
    end
  end

  def least_accurate_team(season_id) #returns a team name, with best ratio of shots and goals
    team_ratios = {}
    team_id_h = @game_teams.group_by { |row| row[:team_id].itself }
    team_id_h.each do |id, array|
      shots = 0.0
      goals = 0.0
      array.each do |row|
        if games_by_season(season_id).include?(row[:game_id])
          shots += row[:shots].to_f
          goals += row[:goals].to_f
        end
      end
      if goals != 0
        team_ratios["#{id}"] = (shots / goals).round(2)
      else
        team_ratios["#{id}"] = 0
      end
    end
    @teams.each do |row|
      if row[:team_id] == team_ratios.min_by{|k,v| v}[0]
        return row[:teamname]
      end
    end
  end









































































  #COLIN
  def average_goals_per_game
    goals = []
    @games.each do |row|
      i = row[:away_goals].to_f + row[:home_goals].to_f
      goals << i
    end
    (goals.sum / goals.count).round(2)
  end

  def average_goals_by_season
    average_by_season = {}
    season_hash = @games.group_by { |row| row[:season].itself }
    season_hash.each do |season, games|
      counter = 0
      game = 0
      games.each do |key|
        counter += (key[:away_goals].to_i + key[:home_goals].to_i)
        game += 1
      end
        average_by_season.merge!(season => (counter.to_f/game.to_f).round(2))
    end
    average_by_season
  end

  def count_of_games_by_season
    season_games_hash = {}
    season_games = @games.group_by { |row| row[:season].itself }
    season_games.each do |season, games|
      game = 0
      games.each do |key|
        game += 1
      end
        season_games_hash.merge!(season => game)
    end
    season_games_hash
  end























































































# T H I A G O O O O O O O A L L L L L
  def winningest_coach#.(season) not implemented yet
    results = @game_teams[:result]
    coaches = @game_teams[:head_coach]
    unique_coaches = coaches.uniq

    win_list = Hash.new(0)

    coach_result = coaches.zip(results)
    win_results = []
    coach_result.each do |g|
      win_results << g if g.include?("WIN")
    end

    unique_coaches.each do |coach|
      win_results.each do |win|
        if coach == win[0] && win_list[coach] == nil
          win_list[coach] = 1
        elsif coach == win[0] && win_list[coach] != nil
          win_list[coach] += 1
        end
      end
    end
    win_list.key(win_list.values.max)


  end


def worst_coach
  results = @game_teams[:result]
  coaches = @game_teams[:head_coach]
  unique_coaches = coaches.uniq

  loss_list = Hash.new(0)

  coach_result = coaches.zip(results)
  loss_results = []
  coach_result.each do |g|
    loss_results << g if g.include?("LOSS")
  end


  unique_coaches.each do |coach|
    loss_results.each do |loss|
      if coach == loss[0] && loss_list[coach] == nil
        loss_list[coach] = 1
      elsif coach == loss[0] && loss_list[coach] != nil
        loss_list[coach] += 1
      end
    end
  end
  loss_list.key(loss_list.values.min)
end


























  #stephen

  def count_of_teams
    @team_ids = []
    @teams[:team_id].each do |id|
      if !@team_ids.include?(id.to_i)
        @team_ids << id.to_i
      end
    end
    @team_ids.count
  end

  def team_average_number_of_goals_per_game(team_id)
    @game_count = 0
    @game_score = 0
    @game_teams.each do |row|
      if row[:team_id].to_i == team_id.to_i
        @game_count += 1
        @game_score += row[:goals].to_i
      end
    end
    @game_score.to_f / @game_count.to_f
  end

  def best_offense
    @teams_hash = {}
    @id_avg_hash = {}
    @team_ids = game_teams[:team_id].uniq
    @teams.each do |row|
      @teams_hash.merge!("#{row[:team_id]}" => row[:teamname])
    end
    @team_ids.each do |id|
      @id_avg_hash.merge!("#{@teams_hash[id]}" => team_average_number_of_goals_per_game(id))
    end
    @id_avg_hash.each do |k, v|
      if v == @id_avg_hash.values.max
        return k
      end
    end
  end

  def worst_offense
    @teams_hash = {}
    @id_avg_hash = {}
    @team_ids = game_teams[:team_id].uniq
    @teams.each do |row|
      @teams_hash.merge!("#{row[:team_id]}" => row[:teamname])
    end
    @team_ids.each do |id|
      @id_avg_hash.merge!("#{@teams_hash[id]}" => team_average_number_of_goals_per_game(id))
    end
    @id_avg_hash.each do |k, v|
      if v == @id_avg_hash.values.min
        return k
      end
    end
  end
































































































end
