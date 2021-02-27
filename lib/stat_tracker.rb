require 'CSV'
require_relative './games_manager'
require_relative './teams_manager'
require_relative './game_teams_manager'

class StatTracker

  def initialize(games_path, team_path, game_team_path)
    @games = GamesManager.new(games_path)
    @teams = TeamsManager.new(team_path)
    @game_teams = GameTeamsManager.new(game_team_path)
  end

  def self.from_csv(data_locations)
    games_path = data_locations[:games]
    teams_path = data_locations[:teams]
    game_teams_path = data_locations[:game_teams]

    StatTracker.new(games_path, teams_path, game_teams_path)
  end

  ####### Game Stats ########
  def highest_total_score
    @games.highest_total_score
  end

  def lowest_total_score
    @games.lowest_total_score
  end
  ###########################

  ###### Team Stats #########

  ###########################

  ###### League Stats #######

  ###########################

  ###### Season Stats #######

  def most_tackles(season)
    season_games = @games.get_season_games(season)
    tackle_hash = @game_teams.get_team_tackle_hash(season_games)
    team_id = tackle_hash.key(tackle_hash.values.max)
    @teams.get_team_name(team_id)
  #  require 'pry' ; binding.pry
  end

  def fewest_tackles(season)
    season_games = @games.get_season_games(season)
    tackle_hash = @game_teams.get_team_tackle_hash(season_games)
    team_id = tackle_hash.key(tackle_hash.values.min)
    @teams.get_team_name(team_id)

  end

  def most_accurate_team(season)
    season_games = @games.get_season_games(season)
    score_ratios = @game_teams.score_ratios_hash(season_games)
    team_id = score_ratios.key(score_ratios.values.max)
    @teams.get_team_name(team_id)
  end

  def least_accurate_team(season)
    season_games = @games.get_season_games(season)
    score_ratios = @game_teams.score_ratios_hash(season_games)
    team_id = score_ratios.key(score_ratios.values.min)
    @teams.get_team_name(team_id)
  end


  # def winninget_coach(season)
  #   season_games = @games.get_season_games(season)
  #   @game_teams.winningest_coach(season_games)
    # def winningest_coach(season_games)
    #   hash = Hash.new { |hash, team| hash[team] = [0,0] }
    #   for game_team in list of all game_teams,
    #     if season_games.include?(game_team.game_id)
    #       hash[game_team.coach][1] += 1
    #       if game_team.win == "win"
    #         hash[game_team.coach][0] += 1
    #       end
    #      end
    #    end
    #    calculate_ratios() for every key value pair etc. etc etc
    # end
  #  convert team id into team name
  # end



  ###########################
end
