class Game
  attr_reader :game_id,
              :season,
              :game_type, 
              :home_team_id, 
              :away_team_id,
              :home_team_goals,
              :away_team_goals,
              :stadium,
              :home_team_coach,
              :away_team_coach,
              :home_team_shots,
              :away_team_shots,
              :home_team_tackles,
              :away_team_tackles,
              :goals,
              :shots,
              :tackles,
              :hoa
  def initialize(game_info, half_game_info)
    @game_id = game_info[:game_id]
    @season = game_info[:season]
    @game_type = game_info[:type]
    @home_team_id = game_info[:home_team_id]
    @away_team_id = game_info[:away_team_id]
    @stadium = game_info[:venue]
    @hoa = half_game_info[:hoa]
    if @hoa == "home"
      @home_team_coach = half_game_info[:head_coach]
      @home_team_shots = half_game_info[:shots].to_i
      @home_team_tackles = half_game_info[:tackles].to_i
      @home_team_goals = game_info[:home_goals].to_i
      @goals = @home_team_goals
      @shots = @home_team_shots
      @tackles = @home_team_tackles
    end
    if @hoa == "away"
      @away_team_coach = half_game_info[:head_coach]
      @away_team_shots = half_game_info[:shots].to_i
      @away_team_tackles = half_game_info[:tackles].to_i
      @away_team_goals = game_info[:away_goals].to_i
      @goals = @away_team_goals
      @shots = @away_team_shots
      @tackles = @away_team_tackles
    end
  end

end
