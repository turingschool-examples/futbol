class StatTracker
  attr_reader :all_data, :games, :seasons_list
  
  def initialize(all_data)
    @all_data = all_data
    @games = []
    @seasons_list = []
  end

  def self.from_csv(locations)
    all_data = {}
    locations.each do |file_name, location|
      formatted_csv = CSV.open location, headers: true, header_converters: :symbol
      all_data[file_name] = formatted_csv
    end
    StatTracker.new(all_data)
  end

  ## Creates game objects from the CSV file
  def create_games
    @all_data[:game_team_f].each do |row|
      game = Game.new(row[:game_id],row[:team_id],row[:goals])
      @games << game
    end
    @games
  end

  ## Returns highest total score of added scores of that game
  def highest_total_score
    games_hash = {}
    game_ids.each do |game_id|
      games_hash[game_id]=0
    end

    @games.each do |game|
      games_hash[game.game_id]+=game.goals.to_i
    end
    games_hash.values.max
  end

  ## Returns lowest total score of added scores of that game
  def lowest_total_score
    games_hash = {}
    game_ids.each do |game_id|
      games_hash[game_id]=0
    end

    @games.each do |game|
      games_hash[game.game_id]+=game.goals.to_i
    end
    games_hash.values.min
  end

  ## A hash with season names (e.g. 20122013) as keys and counts of games as values
  def count_of_games_by_season
  count_games = {}
   seasons_list.each do |entry|
    if count_games[entry[:season]].nil?
      count_games[entry[:season]] = 0
    else
      count_games[entry[:season]] +=1
    end
   end
   count_games
  end

  ## Helper method to create a seasons list from the games_fixture file
  def seasons_list
    @all_data[:games_f].each do |row|
        @seasons_list << {season: row[:season], game_id: row[:game_id], away_goals: row[:away_goals], home_goals: row[:home_goals]}
      end
     @seasons_list
  end

  ## Creates an array of game_ids, acts as helper method
  def game_ids
    @game_ids = @games.map{|game| game.game_id}
  end

end