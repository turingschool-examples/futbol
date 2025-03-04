class LeagueStatistics
    attr_reader :games, :teams, :game_teams

    def initialize(games, teams, game_teams)
        @games = games
        @teams = teams
        @game_teams = game_teams
    end

    # Helpers

    def team_name(team_id) # Finds the team name based on the team_id
        team_names = @teams.find do |team|
            team[:team_id] == team_id
        end

        if team_names.nil?
            'Unknown Team'
        else
            team_names[:teamname]
        end
    end

    def calculate_avg_goals(team_id, hoa = nil) #Adding hoa argument to handle separation of values logic
        #Step 1, find all games where the team played (home or away)
        games_played = @games.select do |game|
            if hoa == 'home'
                game[:home_team_id] == team_id #Only home games
            elsif hoa == 'away'
                game[:away_team_id] == team_id #Only away games
            else
                game[:home_team_id] == team_id || game[:away_team_id] == team_id #All games
            end
        end
        #Step 2, sum all goals scored by this team in those games
        total_goals = games_played.sum do |game| #loops through the games_played.
            if game[:home_team_id] == team_id
                game[:home_goals].to_i #Add home goals if the team was the home team
            else
                game[:away_goals].to_i #Add away goals if the team was the away team
            end
        end
        # Step 3, count the number of games the team played
        total_games = games_played.size # Counts the total number of games played by the team

        #Step 4, calculate average goals per game, avoiding zero division
        if total_games.zero? #Guard against zero
            0.0
        else
            (total_goals.to_f / total_games).round(2) # Rounding to handle large decimals. ex 2/3 = .67
        end
    end

    def team_avg_goals_by_hoa(hoa)

        return {} if @games.empty? #Guard against empty
        #Step 1, filter the games by home/away
        filtered_games = @games.select do |game|
            if hoa == 'home'
                game[:home_team_id] != nil #Ensures only home teams are selected
            else
                game[:away_team_id] != nil #Ensures only away teams are selected
            end
        end

        #Step 2, group the filtered games by team ID
        grouped_games = {}

        filtered_games.each do |game|
            team_id = hoa == 'home' ? game[:home_team_id] : game[:away_team_id] #Turnery for if else

            grouped_games[team_id] ||= []
            grouped_games[team_id] << game
        end

        #Step 3, convert team ids to team names
        team_games = {}

        grouped_games.each do |team_id, games|
            team_name_string = team_name(team_id)

            team_games[team_name_string] = games
        end

        #Step 4, Calculate average goals per game for each team
        team_avg_goals = {}

        team_games.each do |team_name, games|
            team_id = hoa == 'home' ? games.first[:home_team_id] : games.first[:away_team_id] #Turnery for if else
            team_avg_goals[team_name] = calculate_avg_goals(team_id, hoa)
        end

        team_avg_goals
    end

    def highest_avg_team(method)
        avg_goals = @teams.map { |team| [team_name(team[:team_id]), calculate_avg_goals(team[:team_id])]}.to_h

        avg_goals.send(method) { |_, avg| avg }[0]
    end

    def lowest_avg_team(method)
        avg_goals = @teams.map { |team| [team_name(team[:team_id]), calculate_avg_goals(team[:team_id])] }.to_h

        #Removing teams with 0.0 from the return
        filtered_avg = avg_goals.reject { |_, avg| avg == 0.0 }

        return "No teams have played games" if filtered_avg.empty? # Return this if no teams have played games

        filtered_avg.send(method) { |_, avg| avg }[0]
    end

    def highest_avg_team_by_hoa(hoa, method)
        goals = team_avg_goals_by_hoa(hoa)

        goals.send(method) { |_, avg| avg }[0]
    end

    # Methods

    def count_of_teams #counts number of teams in the csv
        @teams.size
    end
  
    def best_offense
        highest_avg_team(:max_by)
    end
  
    def worst_offense
        lowest_avg_team(:min_by)
    end
  
    def highest_scoring_visitor
        highest_avg_team_by_hoa('away', :max_by)
    end
  
    def highest_scoring_home_team
        highest_avg_team_by_hoa('home', :max_by)
    end
  
    def lowest_scoring_visitor
        highest_avg_team_by_hoa('away', :min_by)
    end
  
    def lowest_scoring_home_team
        highest_avg_team_by_hoa('home', :min_by)
    end
end