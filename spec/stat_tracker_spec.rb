require 'spec_helper'

RSpec.describe StatTracker do
  context 'initialize' do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    it "exists" do
      expect(stat_tracker).to be_a(StatTracker)
    end

    it "has attributes" do
      expect(stat_tracker.teams).not_to be_empty
      expect(stat_tracker.game_teams).not_to be_empty
      expect(stat_tracker.games).not_to be_empty
    end
  end

  context 'statistics' do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    it "has team info" do
      expected = {
        "team_id" => "18",
        "franchise_id" => "34",
        "team_name" => "Minnesota United FC",
        "abbreviation" => "MIN",
        "link" => "/api/v1/teams/18"
      }

      expect(stat_tracker.team_info("18")).to eq(expected)
    end

    it 'has best and worst seasons' do
      expect(stat_tracker.best_season("15")).to eq("20162017")
      expect(stat_tracker.worst_season("15")).to eq("20142015")
    end

    it 'has an average win percentage' do
      expect(stat_tracker.average_win_percentage("15")).to eq(0.63)
    end

    it "can get most and fewest number of goals" do
      expect(stat_tracker.most_goals_scored("3")).to eq(5)
      expect(stat_tracker.fewest_goals_scored("3")).to eq(0)
    end

    it 'has highest and lowest total scored' do
      expect(stat_tracker.highest_total_score).to eq(7)
      expect(stat_tracker.lowest_total_score).to eq(1)
    end

    it "can give percentage of home wins, away wins, and ties" do
      expect(stat_tracker.percentage_home_wins).to eq(0.67)
      expect(stat_tracker.percentage_visitor_wins).to eq(0.31)
      expect(stat_tracker.percentage_ties).to eq(0.02)
    end

    it 'has a teams count in a league' do
      expect(stat_tracker.count_of_teams).to eq(32)
    end
  end

  context 'favourite oppenent and rival' do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    it 'has a favourite opponent' do
      expect(stat_tracker.favorite_opponent("15")).to eq("North Carolina Courage")
    end

    it 'has a rival' do
      expect(stat_tracker.rival("15")).to eq("Seattle Sounders FC")
    end
  end

  context 'game stats' do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    it 'has average goals per game' do
      expect(stat_tracker.average_goals_per_game).to eq(3.96)
    end

    it 'has average goals by season' do
      expected = {
      "20142015"=>3.63,
      "20152016"=>4.33,
      "20132014"=>4.67,
      "20162017"=>4.24
    }
      expect(stat_tracker.average_goals_by_season).to eq(expected)
    end

    it 'counts games per season' do
      expected = {
        '20132014' => 6,
        '20142015' => 19,
        '20152016' => 9,
        '20162017' => 17
      }
      expect(stat_tracker.count_of_games_by_season).to eq(expected)
    end
  end

  context 'league statistics' do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    it 'has best offense' do
      expect(stat_tracker.best_offense).to eq("Sporting Kansas City")
    end

    it 'has worst offense' do
      expect(stat_tracker.worst_offense).to eq("Houston Dash")
    end

    it 'highest scoring vistor and home team' do
      expect(stat_tracker.highest_scoring_visitor).to eq("Sporting Kansas City")
      expect(stat_tracker.highest_scoring_home_team).to eq("Real Salt Lake")
    end

    it 'lowest scoring vistor and home team' do
      expect(stat_tracker.lowest_scoring_visitor).to eq("Houston Dash")
      expect(stat_tracker.lowest_scoring_home_team).to eq("Houston Dash")
    end
  end


  context 'season stats' do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    it 'has winningest coach' do
      require 'pry'; binding.pry
      expect(stat_tracker.winningest_coach("20132014")).to eq('Alain Vigneault')
    end

    it 'has worst coach' do
      expect(stat_tracker.worst_coach("20132014")).to eq('Darryl Sutter')
    end
  end
end
