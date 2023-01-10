require 'csv'
require_relative 'team'
require_relative 'game'
require_relative 'game_team'
require_relative 'data_factory'
require_relative 'modules/helper_methods'
#would prefer to not make DataFactory the parent... but need to pass SpecHarness (might be worth asking about)

class StatTracker < DataFactory
  include Helpable
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  ## GAME STATISTIC METHODS
    def highest_total_score
      game_score_totals_sorted.last
    end             

    def lowest_total_score
      game_score_totals_sorted.first
    end
    
    def percentage_home_wins
      (home_wins.to_f / games.length).round(2)
    end

    def percentage_visitor_wins
      (away_wins.to_f / games.length).round(2)
    end

    def percentage_ties
      (tie_games.to_f / games.length).round(2)
    end

    def count_of_games_by_season
      hash = {}
      seasons = games.map do |game|
        game.season
      end.uniq.sort
      # seasons = games.map do |game|
      #   game.season
      # end.uniq.sort
      # require 'pry'; binding.pry
      seasons.each do |season|
        hash[season] = []
      # seasons.reduce({}) do |hash, season|
      #   hash[season]
      end
      games.each do |game|
        hash[game.season] << game
      end
      hash.each do |k, v|
        hash[k] = v.count
      end
      hash
    end



    def average_goals_per_game
      total_goals = games.reduce(0) do |sum, game|
        sum + goals_per_game(game)
      end

      (total_goals.to_f/games.length).round(2)
    end
    
    def average_goals_by_season
      hash = count_of_games_by_season
      
      hash.each do |k, v|
        hash[k] = (goals_per_season(k, v)/v.to_f).round(2)
      end

      hash
    end

  ## LEAGUE STATISTIC METHODS
    def count_of_teams
      teams.count
    end

    def best_offense
      sorted_avgs = team_score_averages
      highest_score = sorted_avgs.last[1]

      highest = []
      sorted_avgs.each do |array|
        highest << array.first if array.last == highest_score
      end

      highest_scoring_team = []
      highest.each do |id|
        teams.each do |team|
          highest_scoring_team << team.team_name if team.team_id == id
        end
      end
      highest_scoring_team.join(", ")
    end

    def worst_offense
      sorted_avgs = team_score_averages
      lowest_score = sorted_avgs.first[1]

      lowest = []
      sorted_avgs.each do |array|
        lowest << array.first if array.last == lowest_score
      end

      lowest_scoring_team = []
      lowest.each do |id|
        teams.each do |team|
          lowest_scoring_team << team.team_name if team.team_id == id
        end
      end
      lowest_scoring_team.join(", ")
    end

    def highest_scoring_visitor
      highest_score = visitor_score_averages.last[1]

      highests = []
      visitor_score_averages.each do |array|
        highests << array.first if array.last == highest_score
      end

      highest_scoring_visitors = []
      highests.each do |id|
        teams.each do |team|
          highest_scoring_visitors << team.team_name if team.team_id == id
        end
      end
      highest_scoring_visitors.join(", ")
    end

    def highest_scoring_home_team
      highest_score = home_score_averages.last[1]

      highests = []
      home_score_averages.each do |array|
        highests << array.first if array.last == highest_score
      end

      highest_scoring_home = []
      highests.each do |id|
        teams.each do |team|
          highest_scoring_home << team.team_name if team.team_id == id
        end
      end
      highest_scoring_home.join(", ")
    end

    def lowest_scoring_visitor
      sorted_avgs = visitor_score_averages
      lowest_score = sorted_avgs.first[1]

      lowests = []
      sorted_avgs.each do |array|
        lowests << array.first if array.last == lowest_score
      end

      lowest_scoring_visitors = []
      lowests.each do |id|
        teams.each do |team|
          lowest_scoring_visitors << team.team_name if team.team_id == id
        end
      end
      lowest_scoring_visitors.join(", ")
    end

    def lowest_scoring_home_team
      sorted_avgs = home_score_averages
      lowest_score = sorted_avgs.first[1]

      lowests = []
      sorted_avgs.each do |array|
        lowests << array.first if array.last == lowest_score
      end
      
      lowest_scoring_home = []
      lowests.each do |id|
        teams.each do |team|
          lowest_scoring_home << team.team_name if team.team_id == id
        end
      end
      lowest_scoring_home.join(", ")
    end

  ## SEASON STATISTICS METHODS
    def winningest_coach(season)
      sorted = coaches_win_percentages_hash(season).sort_by{|k,v| v}
      sorted.last[0]
    end
    
    def worst_coach(season)
      sorted = coaches_win_percentages_hash(season).sort_by{|k,v| v}
      sorted.first[0]
    end

    def most_accurate_team(season)
      team_ratio_hash = team_ratio_hash(season)
      sorted_teams = team_ratio_hash.sort_by {|key, value| value}
      
      mat = teams.find do |team|
        team.team_id == sorted_teams.last[0]
      end
      
      mat.team_name
    end

    def least_accurate_team(season)
      team_ratio_hash = team_ratio_hash(season)
      sorted_teams = team_ratio_hash.sort_by {|key, value| value}

      lat = teams.find do |team|
        team.team_id == sorted_teams.first[0]
      end
      
      lat.team_name
    end
    
    def most_tackles(season)
        most_tackles_id = team_total_tackles(season).sort_by { |k, v| v }.last.first
        teams.each do |team|
          return team.team_name if team.team_id == most_tackles_id
        end
    end  

    def fewest_tackles(season)
      fewest_tackles_id = team_total_tackles(season).sort_by { |k, v| v }.first.first
      teams.each do |team|
        return team.team_name if team.team_id == fewest_tackles_id
      end
    end

  ## TEAM STATISTICS METHODS
    def team_info(team_id)
      hash = {}
      team = find_team_id(team_id)
      hash["team_id"] = team.team_id
      hash["franchise_id"] = team.franchise_id
      hash["team_name"] = team.team_name
      hash["abbreviation"] = team.abbreviation
      hash["link"] = team.link

      hash
    end

    def best_season(team_id)
      seasons_perc_win(team_id).last.first
    end

    def worst_season(team_id)
      seasons_perc_win(team_id).first.first
    end

    def average_win_percentage(team)
      team_games = []
      won = []

      game_teams.each do |game_team|
        if game_team.team_id == team
          team_games << game_team
        end
      end

      team_games.each do |team_game|
        if team_game.result == "WIN"
          won << team_game
        end
      end

      (won.count.to_f / team_games.count).round(2)
    end

    def most_goals_scored(teamid)
      goals_scored_sorted(teamid).last
    end
  
    def fewest_goals_scored(teamid)
      goals_scored_sorted(teamid).first
    end

    def favorite_opponent(team_id)
      favorite_id = opponents_win_percentage(team_id).first.first
      find_team_name(favorite_id)
    end

    def rival(team_id)
      favorite_id = opponents_win_percentage(team_id).last.first
      find_team_name(favorite_id)
    end
end