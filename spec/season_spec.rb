require './lib/season'
require './lib/game'
require './lib/game_manager'
require './lib/game_team_manager'

RSpec.describe Season do
  describe 'initialize' do
    it 'exists and has attributes' do
      season = Season.new

      expect(season).to be_instance_of(Season)
      expect(season.games).to eq({})
    end
  end

  describe '#add_game' do
    it '#add_game' do
      season = Season.new
      game_id = "2012030221"
      game = Game.new({"game_id" => "2012030221", "season" => "20122013", "type" => "Postseason", "date_time" => "5/16/13", "away_team_id" => "3", "home_team_id" => "6", "away_goals" => "2", "home_goals" => "3", "venue" => "Toyota Stadium", "venue_link" => "/api/v1/venues/null"})
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_home = game_team_manager.game_teams["2012030221"][:home]
      game_team_away = game_team_manager.game_teams["2012030221"][:away]
      # 2012030221,20122013,Postseason,5/16/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null
      season.add_game(game_id, game, game_team_home, game_team_away)
      hash = {"2012030221" => {game: game, home: game_team_home, away: game_team_away}}

      expect(season.games).to eq(hash)
    end
  end
end
