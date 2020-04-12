require_relative './csv_helper_file'

class TeamRepository

  # this is where team_stats will be held
    attr_reader :teams_collection, :game_teams_collection, :game_collection
  def initialize(game_teams_path, team_path, game_path)
    @game_teams_collection = CsvHelper.generate_game_teams_array(game_teams_path)
    @teams_collection = CsvHelper.generate_team_array(team_path)
    @game_collection = CsvHelper.generate_game_array(game_path)

  end

  def team_info(id)
    info_hash = Hash.new

    @teams_collection.each do |team|
      if team.team_id == id
      info_hash[:team_id] = team.team_id
      info_hash[:franchise_id] = team.franchiseid
      info_hash[:team_name] = team.teamname
      info_hash[:abbreviation] = team.abbreviation
      info_hash[:link] =  team.link
      end
    end
      info_hash
  end

  def average_win_percentage(id)
    win_percent = 0
    total_game = 0
    @game_teams_collection.each do |game|

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
    @game_teams_collection.each do |game|
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
    @game_teams_collection.each do |game|
      if game.team_id == id
        if game.goals < fewest
          fewest = game.goals
        end
      end
    end
    fewest
  end

  def favorite_opponent(id)
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
  eaisiest_team_name = @teams_collection.find do |team|
    team.team_id == eaisiest_team_number
  end
  team_name = eaisiest_team_name.teamname
  team_name
  require "pry";binding.pry

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

  end
