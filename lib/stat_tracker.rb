class StatTracker
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games = Games.new(locations)
    @teams = League.new(locations)
    @game_teams = GameTeams.new(locations)
  end
  
  def highest_total_score
    @games.highest_total_score
  end
  
  def lowest_total_score
    @games.lowest_total_score
  end

  def average_goals_by_season
    @games.average_goals_by_season
  end

  def percent_home_wins
   @games.percent_home_wins
  end

  def percent_away_wins
   @games.percent_away_wins
  end

  def percent_ties
    @games.percent_ties
  end

  def count_of_games_by_season
    @games.count_of_games_by_season
  end

  def average_goals_per_game
    @games.average_goals_per_game
  end

  def count_of_teams
    @teams.count_of_teams
  end

  def best_offense
    get_teamname(@game_teams.best_offense)
  end

  def worst_offense
    get_teamname(@game_teams.worst_offense)
  end

  def highest_scoring_visitor 
    get_teamname(@game_teams.highest_scoring_visitor)

  end

  def lowest_scoring_visitor
    get_teamname(@game_teams.lowest_scoring_visitor)
  end

  def highest_scoring_home_team 
    get_teamname(@game_teams.highest_scoring_home_team)
  end

  def lowest_scoring_home_team
    get_teamname(@game_teams.lowest_scoring_home_team)
  end

  def winningest_coach(season)
    @game_teams.winningest_coach(season)
  end

  def worst_coach(season)
    @game_teams.worst_coach(season)
  end

  def least_accurate_team(season)
    get_teamname(@game_teams.least_accurate_team(season))
  end

  def most_accurate_team(season)
    get_teamname(@game_teams.most_accurate_team(season))
  end

  def most_tackles(season)
    get_teamname(@game_teams.most_tackles(season))
  end

  def least_tackles(season)
    get_teamname(@game_teams.least_tackles(season))
  end

  def team_info(team)
    @teams.team_info(team)
  end

  def best_season(team)
    @game_teams.best_season(team)
  end

  def worst_season(team)
    @game_teams.worst_season(team)
  end

  def average_win_percentage(team)

  end

  def most_goals_scored(team)

  end

  def fewest_goals_scored(team)

  end

  def favorite_opponent(team)

  end

  def rival(team)

  end

  def biggest_team_blowout(team)

  end

  def worst_loss(team)

  end

  def head_to_head(team)

  end

  def seasonal_summary(team)

  end

  # Helper method

  def get_teamname(method)
    index = @teams.team_id.find_index(method)
    @teams.teamname[index]
  end
end

# Method	Description	Return Value
# team_info	
    # A hash with key/value pairs for the following attributes: team_id, franchise_id, team_name, abbreviation, and link	Hash
# best_season	
    # Season with the highest win percentage for a team.	String
# worst_season	
    # Season with the lowest win percentage for a team.	String
# average_win_percentage	
    # Average win percentage of all games for a team.	Float
# most_goals_scored	
    # Highest number of goals a particular team has scored in a single game.	Integer
# fewest_goals_scored	
    # Lowest number of goals a particular team has scored in a single game.	Integer
# favorite_opponent	
    # Name of the opponent that has the lowest win percentage against the given team.	String
# rival	
    # Name of the opponent that has the highest win percentage against the given team.	String
# biggest_team_blowout	
    # Biggest difference between team goals and opponent goals for a win for the given team.	Integer
# worst_loss	
    # Biggest difference between team goals and opponent goals for a loss for the given team.	Integer
# head_to_head	
    # Record (as a hash - win/loss) against all opponents with the opponents’ names as keys and the win percentage against that opponent as a value.	Hash
# seasonal_summary	
    # For each season that the team has played, a hash that has two keys (:regular_season and :postseason), that each point to a hash with the following keys: :win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against.	Hash