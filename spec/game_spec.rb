require 'spec_helper'

RSpec.describe Game do
  before(:all) do
    @games = Game.create_from_csv("./data/games_dummy.csv")
  end

  describe '#initialize' do
    before(:each) do
      game_data = {
        game_id: "2012030221",
        season: "20122013",
        type: "Postseason",
        away_team_id: 3,
        home_team_id: 6,
        away_goals: 2,
        home_goals: 3
        }
      @game1 = Game.new(game_data)
    end

    it 'exists' do
      expect(@game1).to be_an_instance_of Game
    end

    it 'has attributes that can be read' do
      expect(@game1.game_id).to eq "2012030221"
      expect(@game1.season).to eq "20122013"
      expect(@game1.type).to eq "Postseason"
      expect(@game1.away_team_id).to eq 3
      expect(@game1.home_team_id).to eq 6
      expect(@game1.away_goals).to eq 2
      expect(@game1.home_goals).to eq 3
    end

    describe '#Methods' do
      it "can create Game objects using the create_from_csv method" do
        test_game = @games.first

        expect(@games).to all be_a Game

      expect(test_game.game_id).to eq "2012030221"
      expect(test_game.season).to eq "20122013"
      expect(test_game.type).to eq "Postseason"
      expect(test_game.away_team_id).to eq 3
      expect(test_game.home_team_id).to eq 6
      expect(test_game.away_goals).to eq 2
      expect(test_game.home_goals).to eq 3
    end

      it 'can return an array of all game objects' do
        expect(Game.all).to all be_a Game
        expect(Game.all.count).to eq 31
      end

      it '#percentage_home_wins returns correct return value' do
        expect(Game.percentage_home_wins).to be_a Float
        expect(Game.percentage_home_wins).to eq 0.48
      end

      it '#percentage_visitor_wins returns correct return value' do
        expect(Game.percentage_visitor_wins).to be_a Float
        expect(Game.percentage_visitor_wins).to eq 0.29
      end

      it '#percentage_ties returns correct return value' do
        expect(Game.percentage_ties).to be_a Float
        expect(Game.percentage_ties).to eq 0.23
      end

    it 'can return a count of games by season' do
      expected = {
        '20122013' => 9,
        '20132014' => 4,
        '20142015' => 9,
        '20152016' => 2,
        '20162017' => 3,
        '20172018' => 4
      }
      expect(Game.count_of_games_by_season).to eq (expected)
    end

    it 'can return the total number of goals in a season' do
      expected = {
        '20122013' => 43,
        '20132014' => 13,
        '20142015' => 39,
        '20152016' => 7,
        '20162017' => 15,
        '20172018' => 17
      }
      expect(Game.count_of_goals_by_season).to eq (expected)
    end

    it 'can return the average number of goals by season' do
      expected = {
        '20122013' => 4.78,
        '20132014' => 3.25,
        '20142015' => 4.33,
        '20152016' => 3.50,
        '20162017' => 5.00,
        '20172018' => 4.25
      }

        expect(Game.average_goals_by_season).to eq (expected)
      end

      it "gets the highest total score from all games" do
        expect(Game.highest_total_score).to eq(9)
      end

      it "gets the lowest total score from all games" do
        expect(Game.lowest_total_score).to eq(1)
      end
    end
  end

  it 'averages the goals per game' do
    expect(Game.average_goals_per_game).to eq(4.32)
  end
end
