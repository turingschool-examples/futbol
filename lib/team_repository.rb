require_relative './csv_helper_file'

class TeamRepository

  # this is where team_stats will be held
    attr_reader :teams_collection
  def initialize(game_teams_path, team_path)
    @game_teams_collection = CsvHelper.generate_game_teams_array(game_teams_path)
    @teams_collection = CsvHelper.generate_team_array(team_path)
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



end
