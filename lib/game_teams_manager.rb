require_relative './game_team'


class GameTeamsManager
  attr_reader :game_teams

  def initialize(data_path)
    @game_teams = generate_list(data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << GameTeam.new(row)
    end
    list_of_data
  end




  def get_team_tackle_hash(season_games_ids)
    team_tackles_totals =  Hash.new(0)
    @game_teams.each do |game_team|
      if season_games_ids.include?(game_team.game_id)
        team_tackles_totals[game_team.team_id] += game_team.tackles
      end
    end
    team_tackles_totals
  end




  def most_tackles



    # grouping together all games from a season, into a hash. k=season, value = game list
    #
    #
    #
    #
    #
    # hash_of_totalTaklesPerTeam[teamnumber] += takcles
    #
    # take gameBYteams, tackles of team X in that game.
    #   add tackles to team X in hash of teamtackles
    #
    # hash_of_teamstakcles with the k=teamID,value= total_tackles
  end


end
