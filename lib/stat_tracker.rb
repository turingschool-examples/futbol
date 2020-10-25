require 'CSV'

class StatTracker

    def initialize(locations)
        @games_path = locations[:games]
        @teams_path = locations[:teams]
        @game_teams_path = locations[:game_teams]
        @games = make_games
        @game_teams = make_game_teams
    end

    def self.from_csv(locations)
        StatTracker.new(locations)
    end

    def make_games
        games = []
        CSV.foreach(@games_path, headers: true, header_converters: :symbol) do |row|
            game_id = row[:game_id].to_i
            season = row[:season]
            type = row[:type]
            date_time = row[:date_time]
            away_team_id = row[:away_team_id].to_i
            home_team_id = row[:home_team_id].to_i
            away_goals = row[:away_goals].to_i
            home_goals = row[:home_goals].to_i
            venue = row[:venue]
            venue_link = row[:venue_link]

            games << Game.new(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue, venue_link)
        end
        games
    end

    def make_game_teams
      game_teams = []
      CSV.foreach(@game_teams_path, headers: true, header_converters: :symbol) do |row|
          game_id = row[:game_id]
          team_id = row[:team_id]
          hoa = row[:HoA]
          result = row[:result]
          settled_in = row[:settled_in]
          head_coach = row[:head_coach]
          goals = row[:goals].to_i
          shots = row[:shots].to_i
          tackles = row[:tackles].to_i
          pim = row[:pim].to_i
          powerPlayOpportunities = row[:powerPlayOpportunities].to_i
          powerPlayGoals = row[:powerPlayGoals].to_i
          faceOffWinPercentage = row[:faceOffWinPercentage].to_f
          giveaways = row[:giveaways].to_i
          takeaways = row[:takeaways].to_i
          game_teams << GameTeams.new(game_id,team_id,hoa,result,settled_in,head_coach,goals,shots,tackles,pim,powerPlayOpportunities,powerPlayGoals,faceOffWinPercentage,giveaways,takeaways)
      end
      game_teams
    end

    def highest_total_score
        max_score_game = @games.max_by do |game|
            game.away_goals + game.home_goals
        end
        max_score_game.home_goals + max_score_game.away_goals
    end

    def lowest_total_score
        min_score_game = @games.min_by do |game|
            game.away_goals + game.home_goals
        end
        min_score_game.home_goals + min_score_game.away_goals
    end

    def calculate_winner(game)
      if game.home_goals > game.away_goals
        :home
      elsif game.home_goals < game.away_goals
        :away
      else
        :tie
      end
    end

    def percentage_home_wins
      home_wins = @games.count do |game|
        calculate_winner(game) == :home
      end
      (home_wins.to_f / @games.count).round(2)
    end

    def percentage_visitor_wins
      visitor_wins = @games.count do |game|
        calculate_winner(game) == :away
      end
      (visitor_wins.to_f / @games.count).round(2)
    end

    def percentage_ties
      ties = @games.count do |game|
        calculate_winner(game) == :tie
      end
      (ties.to_f / @games.count).round(2)
    end

    def games_by_season
      @games.group_by do |game|
        game.season
      end
    end

    def games_by_team
      @game_teams.group_by do |game|
        game.team_id
      end
    end


    def count_of_games_by_season
      count = {}
      games_by_season.map do |season, games|
        count[season] = games.count
      end
      count
    end

    def average_goals_per_game
      total_goals = @games.map do |game|
          game.away_goals + game.home_goals
      end
      total_goals.sum.to_f / total_goals.count
    end

    def average_goals_by_season
        average_goals = {}
        games_by_season.map do |season , games|
         average_goals[season] = (games.sum {|game|  game.away_goals + game.home_goals}).to_f / games.count 
        end
        average_goals
    end

    def count_of_teams
      @games.map do |game|
        game.away_team_id
        game.home_team_id
      end.uniq.count
    end
  
    def best_offense
    average_goals = {}
    games_by_team.map do |team , games|
     average_goals[team] = (games.sum {|game|  game.goals}).to_f / games.count 
    end
    average_goals.key(average_goals.values.max).to_i
  end

end
