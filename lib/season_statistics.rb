class SeasonStatistics

    def initialize(game_data, team_data)
        @game_data = game_data
        @team_data = team_data
    end



    def most_accurate_team
    end

    def least_accurate_team
    end

    def winningest_coach
        #find coach that is accompanied by winning most
        total_games = Hash.new(0)
        wins = Hash.new(0)

        @game_data.each do |game|
            coach = game[:head_coach]
            total_games[coach] += 1
            wins[coach] += 1 if game[:result] == 'WIN'
        end
       
        highest_percentage_coach = total_games.keys.max_by do |coach|
            win_percentage(wins[coach], total_games[coach])

        end

            highest_percentage_coach
        end
           
        def win_percentage(wins, total)
            return 0 if total == 0
            (wins.to_f / total) * 100
          end

         
      

  

    def worst_coach
        total_games = Hash.new(0)
        wins = Hash.new(0)
        #makes hashes for total games vs wins of each coach
        @game_data.each do |game|
            coach = game[:head_coach]
            total_games[coach] += 1
            wins[coach] += 1 if game[:result] == 'WIN'
        end
       
        lowest_percentage_coach = total_games.keys.min_by do |coach|
            win_percentage(wins[coach], total_games[coach])
        end
            lowest_percentage_coach

     end

    def fewest_tackles
    end

    def most_tackles
    end
end

#for stattracker
# class StatTracker

#     def self.from_csv(locations)
#         StatTracker.new(locations)
#     end

#     def initialize(locations)
        