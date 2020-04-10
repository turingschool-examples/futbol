require_relative './csv_helper_file'

class TeamRepository




    attr_reader :teams_collection
  def initialize(file_path)

    @teams_collection = CsvHelper.generate_team_array(file_path)

     # require"pry";binding.pry
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




end
