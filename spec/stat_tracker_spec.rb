require './lib/stat_tracker'

RSpec.describe StatTracker do
  context 'Iteration 1' do
    before :each do
      game_path = './data/games_dummy.csv'
      team_path = './data/teams_dummy.csv'
      game_teams_path = './data/game_teams_dummy.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      @stat_tracker = StatTracker.from_csv(locations)
    end

    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'has data' do
      expect(@stat_tracker.games).to all(be_an(Game))
      expect(@stat_tracker.teams.values).to all(be_an(Team))
      expect(@stat_tracker.seasons.values).to all(be_an(Season))
    end

    it 'has a lowest total score' do
       expect(@stat_tracker.lowest_total_score).to eq(1)
    end

    it 'show highest_total_score' do
      expect(@stat_tracker.highest_total_score).to eq(8)
    end

    it 'can return average_goals_per_game' do
      expect(@stat_tracker.average_goals_per_game).to eq(3.85)
    end

    it 'can return percentage of home wins as decimal' do
      expect(@stat_tracker.percentage_home_wins).to eq(0.5)
    end

    it 'can return percentage visitor wins as decimal' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.45)
    end

    it 'can return the percentage of ties as a decimal' do
      expect(@stat_tracker.percentage_ties).to eq(0.05)
    end


    it 'can return a hash of the count of games by season' do
      expect(@stat_tracker.count_of_games_by_season).to eq({20122013=>5, 20142015=>7, 20132014=>4, 20152016=>4})
    end

    it 'can return the team name of the Team with the worst/best offense' do
      expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
      expect(@stat_tracker.best_offense).to eq("Portland Timbers")
    end

    it "can return the highest and lowest scoring home team" do
      expect(@stat_tracker.highest_scoring_home_team).to eq "Houston Dash"
      expect(@stat_tracker.lowest_scoring_home_team).to eq('Seattle Sounders FC')
    end

    it 'can return most/least tackles for different seasons' do
      expect(@stat_tracker.most_tackles("20142015")).to eq("Sporting Kansas City")
      expect(@stat_tracker.fewest_tackles("20142015")).to eq("DC United")
      expect(@stat_tracker.most_tackles("20122013")).to eq("Houston Dynamo")
      expect(@stat_tracker.fewest_tackles("20122013")).to eq("FC Dallas")
    end

    it 'can return the most accurate team per season' do
      expect(@stat_tracker.most_accurate_team("20142015")).to eq('Sporting Kansas City')
    end

    it 'can return the least accurate team per season' do
      expect(@stat_tracker.least_accurate_team("20142015")).to eq('DC United')
    end

    it 'can return the highest and lowest scoring visitor team' do
      expect(@stat_tracker.highest_scoring_visitor).to eq('Seattle Sounders FC')
      expect(@stat_tracker.lowest_scoring_visitor).to eq('Houston Dash')
    end

    it 'can return rival team for any team' do
      expect(@stat_tracker.rival("3")).to eq("FC Dallas")
      expect(@stat_tracker.rival("14")).to eq("Houston Dynamo")
    end

    it 'can return the favorite opponent for any team' do
      expect(@stat_tracker.favorite_opponent("3")).to eq("DC United")
      expect(@stat_tracker.favorite_opponent("14")).to eq("Houston Dynamo")
    end

    it 'can count the total teams in the league' do
      expect(@stat_tracker.count_of_teams).to eq(9)
    end
    
    it 'can return the best/worst seasons for a given team' do
      expect(@stat_tracker.best_season("3")).to eq("20142015")
      expect(@stat_tracker.worst_season("3")).to eq("20122013")
    end

    it 'can return the average win percentage over all seasons for a team' do
      expect(@stat_tracker.average_win_percentage("Houston Dynamo")).to eq[0.3]
    end
  end
end
