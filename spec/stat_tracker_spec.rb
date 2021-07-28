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

  context 'Team stats methods' do
    it '#team_info(team_id)' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
      }
      expect(stat_tracker.team_info("18")).to eq(expected)
    end

    it "#find_win_count" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.find_win_count("6")).to eq({20122013=>[70, 38], 20172018=>[94, 50], 20132014=>[94, 54], 20142015=>[82, 31], 20152016=>[82, 33], 20162017=>[88, 45]})
    end

    it "#best_season(team_id)" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.best_season("6")).to eq "20132014"
    end

    it "#worst_season(team_id)" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.worst_season("6")).to eq "20142015"
    end

    it "#{}total_win_count(team_id)" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.total_win_count("6")).to eq 251
    end

    it "#average_win_percentage(team_id)" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.average_win_percentage("6")).to eq 0.49
    end

#MOCK N STUB
    xit "#game_teams_by_id(team_id)" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.game_teams_by_id("18")).to eq 7
    end

    it "#most_goals_scored(team_id)" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.most_goals_scored("18")).to eq 7
    end

    it "#fewest_goals_scored(team_id)" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.fewest_goals_scored("18")).to eq 0
    end

#mock and stub
    xit "#games_against_rivals(team_id)" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.games_against_rivals("18")[3]).to eq 0
    end

    it "#win_percentage_against_rivals(team_id)" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.wins_against_rivals("18")[3]).to eq [10, 4]
    end

    it "#favorite_opponent(team_id)" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.favorite_opponent("18")).to eq("DC United")
    end

    it "#rival(team_id)" do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
    end
  end
end
