require 'csv'

class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data
  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.max
  end

  def lowest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.min
  end

  def percentage_home_wins
    wins =0
    @games_data.each do |row| 
      if row[:away_goals].to_i < row[:home_goals].to_i
        wins += 1
      end
    end
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_visitor_wins
    wins =0
    @games_data.each do |row| 
      if row[:away_goals].to_i > row[:home_goals].to_i
        wins += 1
      end
    end
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_ties
    ties =0 
    @games_data.each do |row| 
      if row[:away_goals].to_i == row[:home_goals].to_i
        ties += 1
      end
    end
    (ties.to_f/games_data.count).round(2)
  end











































#GameClass



































































































  #LeagueClass


































































































#end
  #SeasonClass

  #Method groups game_id by season in a hash
  def season_games
    season = {}
    @games_data.each do |row|
      season[row[:season]] #= row[:game_id]
      require 'pry';binding.pry
    end
  end


#Method returns the name Coach with the best win percentage for the season in a string
  #look at every season
  #find coach name
  #accumulate coach's win/loss/tie
  #compare coach records with other for each season
  def winningest_coach(season)
    
    #different seasons individually to compare them to each other
    #Method compares a season
    








  def season_all_game_id(season)
    season_games = {}
    @games_data.flat_map do |row|
      if season == row[:season]
        if season_games.include?(row[:season])
          season_games[row[:season]].push(row[:game_id])
        elsif #!season_games.include?(row[:season])
          season_games[row[:season]] = [row[:game_id]]
        end
      end
    end
    season_games
  end


end