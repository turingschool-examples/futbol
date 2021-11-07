require 'csv'
require 'simplecov'

SimpleCov.start

class SeasonStats
  attr_reader :season_data
  def initialize(game_team_path, game_path)
    @season_data = CSV.parse(File.read(game_team_path), headers: true)
    @game_data = CSV.parse(File.read(game_path), headers: true)
    # @season_log = {}
    # @alpha_hash_3000 = {}
    @total_games_per_season = 0
    # season_log_method
    # alpha_master_hash_co_high_el_method # <<<<<<<<<<<<<<<<<<
  end

  def season_log_method
    @season_data.each do |game|
        if game["HoA"] == "home"
          @total_games_per_season += 1
        end
        if @season_log.keys.include? (game["team_id"])
        else
          @season_log[game["team_id"]] = [(game["head_coach"]), 0, 0, 0, 0, 0]
        end
        shots = (@season_log[game["team_id"]][3] += (game["shots"]).to_i)
        goals = (@season_log[game["team_id"]][4] += (game["goals"]).to_i)
        tackles = (@season_log[game["team_id"]][5] += (game["tackles"]).to_i)
        @season_log[game["team_id"]] = [(game["head_coach"]), 0, 0, shots, goals, tackles] #<<<<Helps understand hash
        #{"3"=>["John Tortorella", 0, 5, 38, 8, 179], "6"=>["Claude Julien", 9, 0, 76, 24, 271], "5"=>["Dan Bylsma", 0, 4, 32, 2, 150], "17"=>["Mike Babcock", 4, 2, 40, 12, 181], "16"=>["Joel Quenneville", 2, 4, 50, 8, 142]}
      end
      win_loss_counter
    end

    def alpha_hash_3000_method
      @game_data.each do |game|
        if @alpha_hash_3000.keys.include? (game["season"])
        else
          @alpha_hash_3000 = Hash.new { |hash, key| hash[key] = Hash.new { |k, v| k[v] = Array.new } }
          @alpha_hash_3000[game["season"]][game["home_team_id"]] << 0
          # @alpha_hash_3000[game["season"]] = {@alpha_hash_3000[game["home_team_id"]] = @alpha_hash_3000[game["season"][game["home_team_id"]]] => [0, 0, 0, 0, 0, 0]}
        end
      end
      @season_data.each do |game|
        # if @alpha_hash_3000[game["home_team_id"]].keys.include? (game["home_team_id"])
        # else
        #   @alpha_hash_3000[game["season"]] = {@alpha_hash_3000[game["season"][game["home_team_id"]]] = @alpha_hash_3000[game["season"][game["home_team_id"]]] => [0, 0, 0, 0, 0, 0]}
        # end
        shots = @alpha_hash_3000[game["season"]] = (@alpha_hash_3000[game["team_id"]][3] += (game["shots"]).to_i)
        goals = @alpha_hash_3000[game["season"]] = (@alpha_hash_3000[game["team_id"]][4] += (game["goals"]).to_i)
        tackles = @alpha_hash_3000[game["season"]] = (@alpha_hash_3000[game["team_id"]][5] += (game["tackles"]).to_i)
        @alpha_hash_3000[game["season"]] = (@alpha_hash_3000[game["team_id"]] = [(game["head_coach"]), 0, 0, shots, goals, tackles]) #<<<<Helps understand hash

        #{[20122013 => {"3"=>["John Tortorella", 0, 5, 38, 8, 179], "6"=>["Claude Julien", 9, 0, 76, 24, 271], "5"=>["Dan Bylsma", 0, 4, 32, 2, 150], "17"=>["Mike Babcock", 4, 2, 40, 12, 181], "16"=>["Joel Quenneville", 2, 4, 50, 8, 142]}
      end
      win_loss_counter
    end

    def win_loss_counter
      @season_data.each do |game|
        if game["result"] == "WIN"
          @season_log[game["team_id"]][1] += 1
        else
          @season_log[game["team_id"]][2] += 1
        end
      end
    end

    def winningest_coach(season_id) #best win % of season (gameswon/totalgames)
      team_wins = {}
      @game_data.map do |game|
        if game["season"] == season_id
          if game["away_goals"] > game["home_goals"]
            team_wins[game["away_team_id"]] ||= 1
            team_wins[game["away_team_id"]] += 1
          elsif game["home_goals"] > game["away_goals"]
            team_wins[game["home_team_id"]] ||= 1
            team_wins[game["home_team_id"]] += 1
          end
        end
      end
      winningest_team = team_wins.max_by do |team_id, wins|
        wins
      end
      winningest_coach = @season_data.find do |game_team|
        game_team["team_id"] == winningest_team[0]
      end
        winningest_coach["head_coach"]
    end

      # win_percentage = 0.0
      # winningest_coach = nil
      # @season_log.each do |team|
      #   if team[1][1] / (team[1][2] + team[1][1]).to_f > win_percentage #"3" => ["John Tortorella", 0, 5, 38, 8, 179] / "3" => ["John Tortorella", >>>0,+ 5<<<, 38, 8, 179]
      #     winningest_coach = team[1][0]
      #     win_percentage = 100 * (team[1][1] / (team[1][2] + team[1][1])).to_f
      #   else
      #   end
      # end
      # winningest_coach
    #Refactor notes: def return_coach_name(best = true) #def return_coach_name(best = false)

    def worst_coach #worst win % of season (gameswon/totalgames)
      win_percentage = 100.0
      worst_coach = nil
      @season_log.each do |team|
        if team[1][1] / (team[1][2] + team[1][1]).to_f < win_percentage
          worst_coach = team[1][0]
          win_percentage = 100 * (team[1][1] / (team[1][2] + team[1][1])).to_f
        else
        end
      end
      worst_coach
    end

    def most_accurate_team #best ratio of shots to goals for the season
      accuracy = 0.0
      most_accurate_team_id = nil
      @season_log.each do |team|
        if team[1][4] / (team[1][3]).to_f > accuracy
          most_accurate_team_id = team[0] # >>>"3"<<< =>["John Tortorella", 0, 5, 38, 8, 179]
          accuracy = 100 * team[1][4] / (team[1][3]).to_f #"3"=>["John Tortorella", 0, 5, 38, >>>8<<<, 179] / #"3"=>["John Tortorella", 0, 5, >>>38<<<, 8, 179]
        else
        end
      end
      most_accurate_team_id
    end

    def least_accurate_team #worst ratio of shots to goals for the season
      accuracy = 100.0
      least_accurate_team_id = nil
      @season_log.each do |team|
        if team[1][4] / (team[1][3]).to_f < accuracy # "3" => >>>["John Tortorella", 0, 5, 38, >>>8<<<, 179]<<< / "3" => >>>["John Tortorella", 0, 5, >>>38<<<, 8, 179]<<<
          least_accurate_team_id = team[0] # >>>"3"<<< =>["John Tortorella", 0, 5, 38, 8, 179]
          accuracy = 100 * team[1][4] / (team[1][3]).to_f
        else
        end
      end
      least_accurate_team_id
    end

    def most_tackles #most tackles in the season
      tackle_max = 0
      most_tackles_team_id = nil
      @season_log.each do |team|
        if team[1][5] > tackle_max #"3" => ["John Tortorella", 0, 5, 38, 8, >>>179<<<]
          tackle_max = team[1][5] #"3" => ["John Tortorella", 0, 5, 38, 8, >>>179<<<]
          most_tackles_team_id = team[0]
        else
        end
      end
      most_tackles_team_id
    end

    def fewest_tackles #fewest tackles in the season
      tackle_max = 1000
      fewest_tackles_team_id = nil
      @season_log.each do |team|
        if team[1][5] < tackle_max #"3" => ["John Tortorella", 0, 5, 38, 8, >>>179<<<]
          tackle_min = team[1][5] #"3" => ["John Tortorella", 0, 5, 38, 8, >>>179<<<]
          fewest_tackles_team_id = team[0]
        else
        end
      end
      fewest_tackles_team_id
    end
  end
