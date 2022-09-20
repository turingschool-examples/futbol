
module Id
  def team_name_from_id_average(average)
    @teams_data.each do |row|
      return row[:teamname] if average[0] == row[:team_id]
    end
  end
end
