class StatTracker

  attr_reader :all_data, :games, :game_teams, :teams, :game_ids
  
  def initialize(all_data)
    @all_data = all_data
    @games = []
    @game_teams = []
    @teams = []
    @game_ids = []
    @team_ids = []
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

  def create_teams 
    @all_data[:teams].each do |row|
      team = Team.new(row[:team_id],
                      row[:teamname]
                      )
    @teams << team
    end
    @teams
  end

  ## Returns highest total score of added scores of that game (INTEGER)
  def highest_total_score
    games_hash = {}
    game_ids.each do |game_id|
      games_hash[game_id]=0
    end
    @game_teams.each do |game|
      games_hash[game.game_id]+=game.goals.to_i
    end
    games_hash.values.max
  end

  ## Returns lowest total score of added scores of that game (INTEGER)
  def lowest_total_score
    games_hash = {}
    games_hash = {}
    game_ids.each do |game_id|
      games_hash[game_id]=0
    end
    @game_teams.each do |game|
      games_hash[game.game_id]+=game.goals.to_i
    end
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

  ## LEAGUE SCORING
  def highest_scoring_visitor
    team_goals = Hash.new(0)
    @game_teams.each do |game_team|
      if game_team.hoa == 'away' && !team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] = {
          away_games: game_team.goals.to_f,
          total: 1
          }
      elsif game_team.hoa == 'away' && team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id][:away_games] += game_team.goals.to_f
        team_goals[game_team.team_id][:total] += 1
      end
    end
    team_averages = {}
    team_goals.each do |team_goal, value|
      team_averages[team_goal] = (value[:away_games] / value[:total])
    end
    max(team_averages)
  end
  
  def highest_scoring_home_team
    ##Name of the team with the highest average score per game across all seasons when they are home. 
    team_goals = Hash.new(0)
    @game_teams.each do |game_team|
      if game_team.hoa == 'home' && !team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] = {
          home_games: game_team.goals.to_f,
          total: 1
        }
      elsif game_team.hoa == 'home' && team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id][:home_games] += game_team.goals.to_f
        team_goals[game_team.team_id][:total] += 1
      end
    end
    team_averages = {}
    team_goals.each do |team_goal, value|
      team_averages[team_goal] = (value[:home_games] / value[:total])
    end
    max(team_averages)
  end
  
  def lowest_scoring_visitor
    ##Name of the team with the lowest average score per game across all seasons when they are a visitor.
    team_goals = Hash.new(0)
    @game_teams.each do |game_team|
      if game_team.hoa == 'away' && !team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] = {
          away_games: game_team.goals.to_f,
          total: 1
        }
      elsif game_team.hoa == 'away' && team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id][:away_games] += game_team.goals.to_f
        team_goals[game_team.team_id][:total] += 1
      end
    end
    team_averages = {}
    team_goals.each do |team_goal, value|
      team_averages[team_goal] = (value[:away_games] / value[:total])
    end
    min(team_averages)
  end
  
  
  def lowest_scoring_home_team
    ##Name of the team with the lowest average score per game across all seasons when they are at home.
    team_goals = Hash.new(0)
    @game_teams.each do |game_team|
      if game_team.hoa == 'home' && !team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] = {
          home_games: game_team.goals.to_f,
          total: 1
        }
      elsif game_team.hoa == 'home' && team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id][:home_games] += game_team.goals.to_f
        team_goals[game_team.team_id][:total] += 1
      end
    end
    team_averages = {}
    team_goals.each do |team_goal, value|
      team_averages[team_goal] = (value[:home_games] / value[:total])
    end
    min(team_averages)
  end
  
  ##HELPER METHODS
  ## Creates an array of game_ids, acts as helper method
  def game_ids
    @game_ids = @game_teams.map{|game| game.game_id}.uniq
  end
  
  def max(team_averages)
    max = team_averages.max_by{|k,v| v}
    highest_team = @teams.find { |team| team.team_id == max.first}
    highest_team.team_name
  end

  def min(team_averages)
    min = team_averages.min_by{|k,v| v}
    lowest_team = @teams.find { |team| team.team_id == min.first}
    lowest_team.team_name
  end
end
