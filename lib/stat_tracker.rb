require 'csv'
require_relative 'game'
require_relative 'game_team'
require_relative 'team'

class StatTracker
  def initialize()
  end

  def self.from_csv(locations)
    StatTracker.create_items(locations[:games], Game)
    StatTracker.create_items(locations[:game_teams], GameTeam)
    StatTracker.create_items(locations[:teams], Team)
    StatTracker.new()
  end


  def self.create_items(file, item_class)
    csv_options = {
                    headers: true,
                    header_converters: :symbol,
                    converters: :all
                  }
      CSV.foreach(file, csv_options) { |row| item_class.add(item_class.new(row.to_hash)) }
  end

 def find_games(season, type)
    Game.all.select do |game_id, game_data|
      game_data.season == season && game_data.type == type
    end
  end

  def find_regular_season_teams(season)
    teams = []
    find_games(season, "Regular Season").select do |game_id, game_object|
        teams << game_object.home_team_id
        teams << game_object.away_team_id
    end
    teams = teams.uniq
  end

  def find_post_season_teams(season)
    teams = []
    find_games(season, "Postseason").select do |game_id, game_object|
      teams << game_object.home_team_id
      teams << game_object.away_team_id
    end
    teams = teams.uniq
  end

 def find_eligible_teams(season)
    eligible_teams = []
    find_regular_season_teams(season).each do |team_id|
      eligible_teams << team_id
    find_post_season_teams(season).each do |team_id|
      eligible_teams << team_id
      end
    end
    eligible_teams = eligible_teams.uniq
  end

  def win_percentage(season, team_id, type)
      team_games = find_games(season, type).select do |game_id, game_data|
        game_data.home_team_id == team_id || game_data.away_team_id == team_id
      end
      wins = 0
      team_games.each_value do |game_data|
        if team_id == game_data.home_team_id
          wins += 1 if game_data.home_goals > game_data.away_goals
        elsif team_id == game_data.away_team_id
          wins += 1 if game_data.away_goals > game_data.home_goals
        end
      end
      if team_games.count > 0
        percentage = wins.to_f/team_games.count
        percentage.round(3)
      elsif team_games.count == 0
        percentage = 0
      end
  end

  def post_season_decline(season)
    teams = {}
    find_eligible_teams(season).each do |team_id|
      teams[team_id] = win_percentage(season, team_id, "Regular Season") - win_percentage(season, team_id, "Postseason")
    end
    teams
  end

  def biggest_bust(season)
    season = season.to_i
    maximum_decline_team = post_season_decline(season).max_by{|team, win_percentage| win_percentage}
    Team.all[maximum_decline_team[0]].team_name
  end

  def post_season_improvement(season)
    teams = {}
    find_eligible_teams(season).each do |team_id|
      teams[team_id] = win_percentage(season, team_id, "Postseason") - win_percentage(season, team_id, "Regular Season")
    end
    teams
  end

  def biggest_surprise(season)
    season = season.to_i
    maximum_improvement = post_season_improvement(season).max_by{|team, win_percentage| win_percentage}
    Team.all[maximum_improvement[0]].team_name
    end
end
