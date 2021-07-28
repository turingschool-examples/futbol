require './lib/stat_tracker'
require './spec/spec_helper'

RSpec.describe StatTracker do
  context '#initialize' do
    it 'exists' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.new(locations)

      expect(stat_tracker).to be_a StatTracker
    end

    it 'accepts data' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.games[0].game_id).to eq(2012030221)
      expect(stat_tracker.teams[0].team_id).to eq(1)
      expect(stat_tracker.game_teams[0].game_id).to eq(2012030221)
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  context "Game stat methods" do
    it '#highest_total_score' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.highest_total_score).to eq(11)
    end

    it '#lowest_total_score' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.lowest_total_score).to eq(0)
    end

    it '#percentage_home_wins' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.percentage_home_wins).to eq(0.44)
    end

    it '#percentage_visitor_wins' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.percentage_visitor_wins).to eq(0.36)
    end

    it '#percentage_ties' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.percentage_ties).to eq(0.20)
    end

    it '#count_of_games_by_season' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.count_of_games_by_season).to eq({
        "20122013" => 806,
        "20162017" => 1317,
        "20142015" => 1319,
        "20152016" => 1321,
        "20132014" => 1323,
        "20172018" => 1355
        })
    end

    it '#average_goals_per_game' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.average_goals_per_game).to eq(4.22)
    end

    it '#average_goals_by_season' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.average_goals_by_season).to eq({
        "20122013" => 4.12,
        "20162017" => 4.23,
        "20142015" => 4.14,
        "20152016" => 4.16,
        "20132014" => 4.19,
        "20172018" => 4.44
      })
    end
  end

  context 'league stats methods' do
    it '#count_of_teams' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.count_of_teams).to eq(32)
    end

    it '#games_by_team_id' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.games_by_team_id).to be_a Hash
    end

    # mock and stub this bad boy
    xit '#goals_per_team' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.goals_per_team).to eq({
        3 => [2, 2, 1, 2, 1],
        6 => [3, 3, 2, 3, 3]
      })
    end

    it '#team_name_by_team_id' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.team_name_by_team_id(1)).to eq("Atlanta United")
    end

    it '#best_offense' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.best_offense).to eq("Reign FC")
    end

    it '#worst_offense' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.worst_offense).to eq("Utah Royals FC")
    end

# MOCK AND STUB PLZ
    xit '#finds_home_games' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.games_by_hoa("home")).to eq(1)
    end

    it '#highest_scoring_visitor' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    end

    it '#highest_scoring_home_team' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.highest_scoring_home_team).to eq("Reign FC")
    end

    it '#lowest_scoring_visitor' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
    end

    it '#lowest_scoring_home_team' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
    end
  end

  context 'Season stats methods' do
    it '#winningest_coach' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.winningest_coach("20132014")).to eq("Claude Julien")
    end

    it '#worst_coach' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.worst_coach("20132014")).to eq("Peter Laviolette")
    end

    it '#game_ids_by_season' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.game_ids_by_season("20122013").size).to eq(806)
    end

    it '#game_teams_by_season' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.game_teams_by_season("20122013").size).to eq(1612)
    end

    it '#coach_stats_by_season' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.coach_stats_by_season("20122013")["John Tortorella"]).to eq([60, 22])
    end

    it '#team_shots_by_season' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.team_shots_by_season("20122013")[3]).to eq([112, 441])
    end
    it '#most_accurate_team' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
    end
    it "#least_accurate_team" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
      expect(stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
    end

    it "#tackles_by_season" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.tackles_by_season("20132014")[3]).to eq 2675
    end

    it "#most_tackles" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
    end

    it "#fewest_tackles" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
      expect(stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
    end
  end
end
