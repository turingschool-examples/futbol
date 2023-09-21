class StatTracker

  attr_reader :all_data, :games, :game_teams, :teams, :game_ids
  
  def initialize(all_data)
    @all_data = all_data
    @games = []
    @game_teams = []
    @teams = []
    @game_ids = []
  end

  def self.from_csv(locations)
    all_data = {}
    locations.each do |file_name, location|
      formatted_csv = CSV.open location, headers: true, header_converters: :symbol
      all_data[file_name] = formatted_csv
    end
    StatTracker.new(all_data)
  end

  def compile
    create_teams
    create_games
    create_game_teams
    game_ids
  end

  ## Returns highest total score of added scores of that game (INTEGER)
  def highest_total_score
    games_hash.values.max
  end

  ## Returns lowest total score of added scores of that game (INTEGER)
  def lowest_total_score
    games_hash.values.min
  end

  ## A hash with season names (e.g. 20122013) as keys and counts of games as values
  def count_of_games_by_season
  count_games = {}
   @games.each do |game|
    if count_games[game.season].nil? # Added [1] to continue method with adjustment to games_list
      count_games[game.season] = 0
    else
      count_games[game.season] +=1
    end
   end
   count_games
  end

  def percentage_home_wins
    # Percentage of games that a home team has won (rounded to the nearest 100th)
    #find total number of games
    number_of_games = game_ids.length
    #find when home/away is home and result is win
    games_won = 0
    @game_teams.each do |game|
      if game.hoa == 'home' && game.result == 'WIN'
        games_won += 1
      end
    end
    percentage = (games_won.to_f / number_of_games.to_f * 100).round(2)
  end
  
  def percentage_visitor_wins
    ## Percentage of games that a visitor has won (rounded to the nearest 100th)
    ##find total number of games
    number_of_games = game_ids.length
    ##find when home/away is away and result is win
    games_won = 0
    @game_teams.each do |game|
      if game.hoa == 'away' && game.result == 'WIN'
        games_won += 1
      end
    end
    percentage = (games_won.to_f / number_of_games.to_f * 100).round(2)
  end

  def percentage_ties   
    # Percentage of games that has resulted in a tie (rounded to the nearest 100th)
    #total number of games
    number_of_games = game_ids.length
    #result is tie
    games_tied = 0
    @game_teams.each do |game|
      if game.hoa == 'away' && game.result == 'TIE'
        games_tied += 1
      end
    end
    percentage = (games_tied.to_f / number_of_games.to_f * 100).round(2)
  end

  def count_of_teams
    @teams.count
  end

  def team_games_league_total
    @teams.reduce(Hash.new(0)) do |team_games_total, team|
      @game_teams.each do |game|
        team_games_total[team.team_id] += 1 if game.team_id.to_i == team.team_id.to_i
      end
      team_games_total
    end
  end
  
  def team_goals_season_total
    @teams.reduce(Hash.new(0)) do |team_goals_total, team|
      @game_teams.each do |game|
        team_goals_total[team.team_id] += game.goals.to_i if game.team_id.to_i == team.team_id.to_i
      end
      team_goals_total
    end
  end

  def avg_team_goals_season
    team_games_season_total.reduce(Hash.new) do |team_avgs, (team, tot_games)|
      team_goals_season_total.each do |team, tot_goals|
        team_avgs[team] = (tot_goals.to_f / tot_games).round(2)
      end
      team_avgs
    end
  end

  def max_avg_team_goals_season
    max_avg = avg_team_goals_season.values.max
    max_ids = avg_team_goals_season.select do |team_id, average|
      average == max_avg
    end
  end

  def min_avg_team_goals_season
    min_avg = avg_team_goals_season.values.min
    min_ids = avg_team_goals_season.select do |team_id, average|
      average == min_avg
    end
  end

  # Finally the actual methods
  def best_offense
    best_team_ids = max_avg_team_goals_season.keys
    team_names = @teams.reduce([]) do |names, team| 
      best_team_ids.each do |id|
        names << team.team_name if id == team.team_id
      end
      names
    end
    team_names.join(' ')
  end

  def worst_offense
    worst_team_ids = min_avg_team_goals_season.keys
    team_names = @teams.reduce([]) do |names, team| 
      worst_team_ids.each do |id|
        names << team.team_name if id == team.team_id
      end
      names
    end
    team_names.join(', ')
  end

  ## Returns average goals per game across ALL seasons rounded to nearest 100th (FLOAT)
  def average_goals_per_game
    game_count = game_ids.count.to_f
    average_goals_per_game = games_hash.values.sum.to_f/game_count
    average_goals_per_game.round(2)
  end

  ## Returns average goals per game with season names as keys and a float for average num of goals per game (HASH)
  def average_goals_by_season
    total_scores_by_season = {"20122013"=>65, "20152016"=>137, "20162017"=>160, "20172018"=>149}
    average_goals_by_season = total_scores_by_season.map { |season, total_scores| [season, (total_scores.to_f/count_of_games_by_season[season].to_f).round(2)]}.to_h
    average_goals_by_season
  end

##HELPER METHODS
    ## Creates an array of game_ids, acts as helper method
    def game_ids
      @game_ids = @game_teams.map{|game| game.game_id}.uniq
    end

    ## Creates game objects from the CSV file

  def create_teams
    @all_data[:teams].each do |row|
      team = Team.new(row[:team_id], row[:teamname])
      @teams << team
    end
    @teams
  end

  def create_games
    @all_data[:games].each do |row|
      game = Game.new(row[:game_id],
                      row[:season],
                      row[:away_goals],
                      row[:home_goals], 
                      row[:away_team_id], 
                      row[:home_team_id] 
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

    ##Returns a hash of game ID for key and total goals as value
    def games_hash
      games_hash = {}
      game_ids.each do |game_id|
        games_hash[game_id]=0
      end
      @game_teams.each do |game|
        games_hash[game.game_id]+=game.goals.to_i
      end
      games_hash
    end

    ##Returns a hash of season as key and total scores of all games in that season for value
    def total_scores_by_season
      total_scores_by_season = {}
      @games.each do |game|
        if total_scores_by_season[game.season].nil? # Added [1] to continue method with adjustment to games_list
          total_scores_by_season[game.season] = 0
        else
          total_scores_by_season[game.season] += (game.away_goals+game.home_goals)
        end
       end
       total_scores_by_season
    end
end
