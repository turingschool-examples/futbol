require 'csv'
class TeamCollection

  def initialize(team_data)
    rows = CSV.read(team_data, headers: true, header_converters: :symbol)
    @teams = []
    rows.each do |row|
      @teams << Team.new(row)
    end
  end

  def all
    @teams
  end

  # def team_names_and_ids
  #   {
  #     "1" => "Atlanta United",
  #     "4" => "Chicago Fire",
  #     "26" => "FC Cincinnati",
  #     "14" => "DC United",
  #     "6" => "FC Dallas",
  #     "3" => "Houston Dynamo",
  #     "5" => "Sporting Kansas City",
  #     "17" => "LA Galaxy",
  #     "28" => "Los Angeles FC",
  #     "18" => "Minnesota United FC",
  #     "23" => "Montreal Impact",
  #     "16" => "New England Revolution",
  #     "9" => "New York City FC",
  #     "8" => "New York Red Bulls",
  #     "30" => "Orlando City SC",
  #     "15" => "Portland Timbers",
  #     "19" => "Philadelphia Union",
  #     "24" => "Real Salt Lake",
  #     "27" => "San Jose Earthquakers",
  #     "2" => "Seattle Sounders FC",
  #     "20" => "Toronto FC",
  #     "21" => "Vancouver Whitecaps FC",
  #     "25" => "Chicago Red Stars",
  #     "13" =>"Houston Dash",
  #     "10" => "North Carolina Courage",
  #     "29" => "Orlando Pride",
  #     "52" => "Portland Thorns FC",
  #     "54" => "Reign FC",
  #     "12" => "Sky Blue FC",
  #     "7" => "Utah Royals FC",
  #     "22" => "Washington Spirit FC",
  #     "53" => "Columbus Crew SC"
  #   }
  # end

end
