require 'CSV'

class StatTracker
  attr_reader :games,
              :teams, 
              :game_teams,
              :game_id
             
  def initialize(locations)
    @games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @game_id = @games[:game_id]
    @season = @games[:season]
    @type = @games[:type].to_s
    @date_time = @games[:date_time]
    @away_team_id = @games[:away_team_id]
    @home_team_id = @games[:home_team_id]
    @away_goals = @games[:away_goals]
    @home_goals = @games[:home_goals]
    @venue = @games[:venue].to_s
    @venue_link = @games[:venue_link].to_s
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
    
  def highest_total_score
    total_scores = []
    @games.each do |row|
      total_scores << row[:away_goals].to_i + row[:home_goals].to_i
    end
    total_scores.max
  end

  def lowest_total_score
    total_scores = []
    @games.each do |row|
      total_scores << row[:away_goals].to_i + row[:home_goals].to_i
    end
    total_scores.min
  end

  def percentage_home_wins
    count = @games.count do |row|
      row[:home_goals].to_i > row[:away_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end

  def percentage_visitor_wins
    count = @games.count do |row|
      row[:away_goals].to_i > row[:home_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end

  def percentage_ties
    count = @games.count do |row|
      row[:away_goals].to_i == row[:home_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end



  def count_of_teams 
    @teams.count
  end


  # def map_team_id
  #   team = teams.map do |row|
  #     row[:team_id]
  #   end
  #   team
  # end

  # def game_teams_group_by_team_id
  #   @game_teams.group_by(find_team_id)
  # end

  # def team_ids_by_goals_hash
  #   teams_hash = game_teams_group_by_team_id

  #   teams_hash.each do |team_id, game_teams|
  #     teams_hash[team_id] = (game_teams.map(&:goals).map(&:to_i).sum.to_f / game_teams.count).round(2)
  #   end
  # end
  def best_offense
    teams = []
    @games.each do |row|
      teams.push([row[:home_team_id], row[:home_goals]])
      teams.push([row[:away_team_id], row[:away_goals]])
    end

    hash = Hash.new {|hash, key| hash[key] = []}
    teams.each do |array|
      hash[array[0]] <<array[1].to_i
    end

    hash.each do |k, v|
      if v.size>1
        hash[k] = v.sum
      else
        hash[k] = v[0]
      end
    end

    max_team = hash.max_by do |k, v|
      v
    end

    best_offense = nil
    @teams.each do |team|
      best_offense = team[:teamname] if team[:team_id] == max_team[0]
    end
    best_offense
  end
end



















