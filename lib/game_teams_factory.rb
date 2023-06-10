class GameTeamsFactory
  attr_reader :game_teams

  def initialize
    @game_teams = []
  end 


  def create_game_teams(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      game_teams_details = {
        :game_id => row[:game_id], 
        :team_id => row[:team_id],
        :HoA => row[:HoA],
        :result => row[:result], 
        :settled_in => row[:settled_in], 
        :head_coach => row[:head_coach], 
        :goals => row[:goals], 
        :shots => row[:shots], 
        :tackles => row[:tackles],
        :pim => row[:pim],
        :power_play_opportunities => row[:powerplayopportunities],
        :power_play_goals => row[:powerplaygoals],
        :face_off_win_percentage => row[:faceoffwinpercentage],
        :giveaways => row[:giveaways],
        :takeaways => row[:takeaways]
      }
      game_teams.push(game_teams_details)
    end
  end



end