class StatTracker

  attr_reader :all_data, :games, :games_list
  
  def initialize(all_data)
    @all_data = all_data
    @games = []
    @game_teams = []
    @teams = []
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
    @all_data[:games].each do |row|
      game = Game.new(row[:season],
                      row[:away_goals],
                      row[:home_goals], 
                      )
      @games << game
    end
    @games
  end

  def create_game_teams
    @all_data[:game_teams].each do |row|
      game_team = GameTeam.new(row[:game_id],
                      row[:team_id],
                      row[:goals], 
                      row[:hoa], 
                      row[:result]
                      )
      @game_teams << game_team
    end
    @game_teams
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
  games_list
  count_games = {}
   @games_list.each do |entry|
    if count_games[entry[1][:season]].nil? # Added [1] to continue method with adjustment to games_list
      count_games[entry[1][:season]] = 0
    else
      count_games[entry[1][:season]] +=1
    end
   end
   count_games
  end

  ## Helper method to create a seasons list from the games_fixture file
  def games_list
    @all_data[:games_f].each do |row|
      @games_list[row[:game_id]] = {season: row[:season], away_goals: row[:away_goals], home_goals: row[:home_goals]}
    end
    @games_list
  end

  def games_team_list
    @all_data[:game_team_f].each do |row|
      @games_team_list[row[:game_id]] = {home_away: row[:hoa], goals: row[:goals]}
    end
    @games_team_list
    # games_team_list
  end

  ## Creates an array of game_ids, acts as helper method
  def game_ids
    @game_ids = @games.map{|game| game.game_id}.uniq
  end

  # require 'pry'; binding.pry

  def percentage_home_wins
    # Percentage of games that a home team has won (rounded to the nearest 100th)
    #find total number of games
    all_games = @games.map do |game|
      game.game_id
    end
    number_of_games = all_games.uniq.length
    #find when home/away is home and result is win
    games_won = 0
    @games.each do |game|
      if game.hoa == 'home' && game.result == 'WIN'
        games_won += 1
      end
    end
    percentage = (games_won.to_f / number_of_games.to_f * 100).round(2)
  end
  
  def percentage_visitor_wins
    ## Percentage of games that a visitor has won (rounded to the nearest 100th)
    ##find total number of games
    all_games = @games.map do |game|
      game.game_id
    end
    number_of_games = all_games.uniq.length
    ##find when home/away is away and result is win
    games_won = 0
    @games.each do |game|
      if game.hoa == 'away' && game.result == 'WIN'
        games_won += 1
      end
    end
    percentage = (games_won.to_f / number_of_games.to_f * 100).round(2)
  end

  def percentage_ties   
    # Percentage of games that has resulted in a tie (rounded to the nearest 100th)
    #total number of games
    all_games = @games.map do |game|
      game.game_id
    end
    number_of_games = all_games.uniq.length
    #result is tie
    games_tied = 0
    @games.each do |game|
      if game.hoa == 'away' && game.result == 'TIE'
        games_tied += 1
      end
    end
    percentage = (games_tied.to_f / number_of_games.to_f * 100).round(2)
  end
end
