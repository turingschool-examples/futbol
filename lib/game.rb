class Game 
  attr_reader :game_data

  def initialize(data)
    @game_data = data
  end

  def highest_total_score
    @game_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.max
  end

  def lowest_total_score
    @game_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.min
  end
  

  # Percentage of games that has 
  # resulted in a tie (rounded to the nearest 100th)
  def percentage_ties
    away = 0
    data = CSV.parse(File.read(@game_data), headers: true, header_converters: :symbol)
    data.each do |a_goal|
      away += [:away_goals]
    end
    away
  end

    #find total games - make helper method?
    # goals = 0
    # data.each do |away|
    #   goals += away[:away_goals]
  # end

    #find total games where home_goals = away_goals
  # end


  #A hash with season names 
  # (e.g. 20122013) as keys and counts of games as values
  def count_of_games_by_season
    data = @game_data[:games]
    CSV.parse(File.read(data), headers: true)

    #using second column "season" use date format to make "name" key
    #count number of games per season and apply as value
    
  end
  
end