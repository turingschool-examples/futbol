require_relative './csv_helper_file'
require_relative './repository'
class TeamRepository < Repository

  attr_reader :team_collection, :game_team_collection, :game_collection

  def team_info(id)
    info_hash = Hash.new
    number_id = id.to_i
    @team_collection.each do |team|
      if team.team_id == number_id
      info_hash["team_id"] = team.team_id.to_s
      info_hash["franchise_id"] = team.franchiseid.to_s
      info_hash["team_name"] = team.teamname.to_s
      info_hash["abbreviation"] = team.abbreviation.to_s
      info_hash["link"] =  team.link.to_s
      end
    end
      info_hash
  end

  def best_season(string_id)
    id = string_id.to_i

    season_win_percent = Hash.new
    count = 0
    wins = @game_collection.each do |game|

      if game.away_team_id == id && (game.away_goals > game.home_goals) && (season_win_percent[game.season] == nil)
         # && season_win_percent[game.season] == nil
        season_win_percent[game.season] = 0
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.home_team_id == id && (game.home_goals > game.away_goals) && (season_win_percent[game.season] == nil)
        season_win_percent[game.season] = 0
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.away_team_id == id && (game.away_goals > game.home_goals)
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.home_team_id == id && (game.home_goals > game.away_goals)
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      end
       end

    best_percent = season_win_percent.max_by do |key, value|
      season_win_percent[key]
    end
      best_percent.first
  end

  def games_per_season(id, game_season)
    games_per_season = 0
    @game_collection.each do |game|

      if (game.away_team_id == id || (game.home_team_id == id)) && (game.season == game_season)
        games_per_season += 1
      end
    end
    games_per_season
  end

  def worst_season(string_id)
    id = string_id.to_i
    season_win_percent = Hash.new
    count = 0
    wins = @game_collection.each do |game|

      if game.away_team_id == id && (game.away_goals > game.home_goals) && (season_win_percent[game.season] == nil)
        season_win_percent[game.season] = 0
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.home_team_id == id && (game.home_goals > game.away_goals) && (season_win_percent[game.season] == nil)
        season_win_percent[game.season] = 0
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.away_team_id == id && (game.away_goals > game.home_goals)
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.home_team_id == id && (game.home_goals > game.away_goals)
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      end
    end
    best_percent = season_win_percent.min_by do |key, value|
      season_win_percent[key]
    end
      best_percent.first

  end




  def average_win_percentage(string_id)
    id = string_id.to_i
    win_percent = 0
    total_game = 0
    @game_team_collection.each do |game|

      if (game.team_id == id) && (game.result == "WIN")
        win_percent += 1
      end
      if (game.team_id == id)
      total_game += 1
      end
    end
    win_percent
    total_game
    average_wins = (win_percent.to_f / total_game).round(2)
    end


  def most_goals_scored(id)
    id = id.to_i
    most = 0
    @game_team_collection.each do |game|
      if game.team_id == id
        if game.goals > most
          most = game.goals
        end
      end
    end
    most
  end

  def fewest_goals_scored(id)
    id = id.to_i
    fewest = 1000
    @game_team_collection.each do |game|
      if game.team_id == id
        if game.goals < fewest
          fewest = game.goals
        end
      end
    end
    fewest
  end

  def favorite_opponent(string_id)
    id = string_id.to_i
    opponent_hash = Hash.new
    @game_collection.each do |game|
      # require"pry";binding.pry
      if (game.away_team_id == id) && (opponent_hash[game.home_team_id] == nil) && (game.away_goals > game.home_goals)
        opponent_hash[game.home_team_id] = 0
        opponent_hash[game.home_team_id] += (1.to_f / total_matches(id, game.home_team_id))
      elsif (game.away_team_id == id) && (game.away_goals > game.home_goals)
          opponent_hash[game.home_team_id] += (1.to_f / total_matches(id, game.home_team_id))
        elsif (game.home_team_id == id) && (opponent_hash[game.away_team_id] == nil)  && (game.home_goals > game.away_goals)
          opponent_hash[game.away_team_id] = 0
          opponent_hash[game.away_team_id] += (1.to_f / total_matches(id, game.away_team_id))
        elsif (game.home_team_id == id) && (game.home_goals > game.away_goals)
          opponent_hash[game.away_team_id] += (1.to_f / total_matches(id, game.away_team_id))
        end

      end

      eaisiest_win = opponent_hash.max_by do |key, value|
        opponent_hash[key]
      end
      eaisiest_team_number = eaisiest_win.first
      eaisiest_team_name = @team_collection.find do |team|
        team.team_id == eaisiest_team_number
      end
      team_name = eaisiest_team_name.teamname
      team_name


  end

  def total_matches(id, team_id)

    count = 0
    @game_collection.each do |game|
      if ((game.home_team_id == id) || (game.away_team_id == id ))&& ((game.away_team_id == team_id) || (game.home_team_id == team_id))
        count += 1
      end
    end

    count


  end

    def rival(string_id)
      id = string_id.to_i
      opponent_hash = Hash.new
      @game_collection.each do |game|
        # require"pry";binding.pry
        if (game.away_team_id == id) && (opponent_hash[game.home_team_id] == nil) && (game.away_goals > game.home_goals)
          opponent_hash[game.home_team_id] = 0
          opponent_hash[game.home_team_id] += (1.to_f / total_matches(id, game.home_team_id))
        elsif (game.away_team_id == id) && (game.away_goals > game.home_goals)
            opponent_hash[game.home_team_id] += (1.to_f / total_matches(id, game.home_team_id))
        elsif (game.home_team_id == id) && (opponent_hash[game.away_team_id] == nil)  && (game.home_goals > game.away_goals)
          opponent_hash[game.away_team_id] = 0
          opponent_hash[game.away_team_id] += (1.to_f / total_matches(id, game.away_team_id))
        elsif (game.home_team_id == id) && (game.home_goals > game.away_goals)
          opponent_hash[game.away_team_id] += (1.to_f / total_matches(id, game.away_team_id))
        end

        end

        eaisiest_win = opponent_hash.min_by do |key, value|
          opponent_hash[key]
        end
        eaisiest_team_number = eaisiest_win.first
        eaisiest_team_name = @team_collection.find do |team|
          team.team_id == eaisiest_team_number
        end
        team_name = eaisiest_team_name.teamname
        team_name
      end
end
