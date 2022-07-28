class Game

  attr_reader :game_id,
              :season,
              :type,
              :teams_game_stats

  def initialize(game_csv_row, game_teams_csv_rows, home_name, away_name)
    @game_id = game_csv_row[:game_id]
    @season = game_csv_row[:season]
    @type = game_csv_row[:type]
    @teams_game_stats = generate_team_stats(game_teams_csv_rows, home_name, away_name)
# require 'pry'; binding.pry
  end

  def generate_team_stats(data, home_name, away_name)
    {
      home_team: {
        team_id: data[1][:team_id],
        team_name: home_name,
        goals: data[1][:goals],
        shots: data[1][:shots],
        tackles: data[1][:tackles],
        head_coach: data[1][:head_coach],
        face_off_win_percentage: data[1][:faceoffwinpercentage],
        result: data[1][:result]
      },
      away_team: {
        team_id: data[0][:team_id],
        team_name: away_name,
        goals: data[0][:goals],
        shots: data[0][:shots],
        tackles: data[0][:tackles],
        head_coach: data[0][:head_coach],
        face_off_win_percentage: data[0][:faceoffwinpercentage],
        result: data[0][:result]
      }
    }
  end

  def total_goals #returns total number of goals scored by either team in a game
    @teams_game_stats[:home_team][:goals] + @teams_game_stats[:away_team][:goals]
  end
  
  def winner #returns either :home_team or :away_team or :tie for winner
    if @teams_game_stats[:home_team][:result] == "WIN"
      :home_team
    elsif @teams_game_stats[:home_team][:result] == "TIE"
      :tie
    else
      :away_team
    end
  end

  def self.generate_games(games_csv, game_teams_csv, teams)
    game_array = []
    games_csv.each do |game|
      game_teams_csv_rows = game_teams_csv.find_all do |game_team|
        game_team[:game_id] == game[:game_id]
      end
      home_team = teams.values.find{ |team| team.team_id == game[:home_team_id] }
      away_team = teams.values.find{ |team| team.team_id == game[:away_team_id] }
      this_game = Game.new(game, game_teams_csv_rows, home_team.team_name, away_team.team_name)
      home_team.games_participated_in << this_game
      away_team.games_participated_in << this_game
      game_array << this_game
      # require 'pry'; binding.pry
    end
    game_array
  end


   
end

