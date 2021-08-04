require './lib/game'

RSpec.describe Game do
  describe 'initialization' do
    it 'exists and has attributes' do
      game = Game.new({
        "game_id"      => "2012030221",
        "season"       => "20122013",
        # "type"         => "Postseason",
        # "date_time"    => "5/16/13",
        "away_team_id" => "3",
        "home_team_id" => "6",
        "away_goals"   => 2,
        "home_goals"   => 3
        # "venue"        => "Toyota Stadium",
        # "venue_link"   => "/api/v1/venues/null"
      })

      expect(game).to be_a(Game)
      expect(game.game_id).to eq("2012030221")
    end
  end
end
