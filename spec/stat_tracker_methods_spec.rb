require 'rspec'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before :each do
    @games = [
      { game_id: '2012030221', season: '20122013', type: 'Postseason', date_time: '5/16/13', away_team_id: '3', home_team_id: '6', away_goals: '2', home_goals: '3', venue: 'Toyota Stadium', venue_link: '/api/v1/venues/null' },
      { game_id: '2012030222', season: '20122013', type: 'Postseason', date_time: '5/19/13', away_team_id: '3', home_team_id: '6', away_goals: '2', home_goals: '3', venue: 'Toyota Stadium', venue_link: '/api/v1/venues/null' },
      { game_id: '2012030223', season: '20122013', type: 'Postseason', date_time: '5/21/13', away_team_id: '6', home_team_id: '3', away_goals: '2', home_goals: '1', venue: 'BBVA Stadium', venue_link: '/api/v1/venues/null' },
      { game_id: '2012030224', season: '20122013', type: 'Postseason', date_time: '5/23/13', away_team_id: '6', home_team_id: '3', away_goals: '3', home_goals: '2', venue: 'BBVA Stadium', venue_link: '/api/v1/venues/null' },
      { game_id: '2012030225', season: '20122013', type: 'Postseason', date_time: '5/25/13', away_team_id: '3', home_team_id: '6', away_goals: '1', home_goals: '3', venue: 'Toyota Stadium', venue_link: '/api/v1/venues/null' }
    ]

    @game_teams = [
      { game_id: '2012030221', team_id: '3', HoA: 'away', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: '2', shots: '8', tackles: '44', pim: '8', powerPlayOpportunities: '3', powerPlayGoals: '0', faceOffWinPercentage: '44.8', giveaways: '17', takeaways: '7' },
      { game_id: '2012030221', team_id: '6', HoA: 'home', result: 'WIN', settled_in: 'OT', head_coach: 'Claude Julien', goals: '3', shots: '12', tackles: '51', pim: '6', powerPlayOpportunities: '4', powerPlayGoals: '1', faceOffWinPercentage: '55.2', giveaways: '4', takeaways: '5' },
      { game_id: '2012030222', team_id: '3', HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: '2', shots: '9', tackles: '33', pim: '11', powerPlayOpportunities: '5', powerPlayGoals: '0', faceOffWinPercentage: '51.7', giveaways: '1', takeaways: '4' },
      { game_id: '2012030222', team_id: '6', HoA: 'home', result: 'WIN', settled_in: 'REG', head_coach: 'Claude Julien', goals: '3', shots: '8', tackles: '36', pim: '19', powerPlayOpportunities: '1', powerPlayGoals: '0', faceOffWinPercentage: '48.3', giveaways: '16', takeaways: '6' },
      { game_id: '2012030223', team_id: '6', HoA: 'away', result: 'WIN', settled_in: 'REG', head_coach: 'Claude Julien', goals: '2', shots: '8', tackles: '28', pim: '6', powerPlayOpportunities: '0', powerPlayGoals: '0', faceOffWinPercentage: '61.8', giveaways: '10', takeaways: '7' }
    ]

    @teams = [
      { team_id: '1', franchiseId: '23', teamName: 'Atlanta United', abbreviation: 'ATL', Stadium: 'Mercedes-Benz Stadium', link: '/api/v1/teams/1' },
      { team_id: '2', franchiseId: '22', teamName: 'Seattle Sounders FC', abbreviation: 'SEA', Stadium: 'CenturyLink Field', link: '/api/v1/teams/2' },
      { team_id: '3', franchiseId: '21', teamName: 'Portland Timbers', abbreviation: 'POR', Stadium: 'Providence Park', link: '/api/v1/teams/3' },
      { team_id: '4', franchiseId: '20', teamName: 'New York Red Bulls', abbreviation: 'NY', Stadium: 'Red Bull Arena', link: '/api/v1/teams/4' },
      { team_id: '6', franchiseId: '19', teamName: 'LA Galaxy', abbreviation: 'LA', Stadium: 'StubHub Center', link: '/api/v1/teams/6' }
    ]

    @stat_tracker = StatTracker.new(@games, @game_teams, @teams)
  end
# Game Statistics

  it 'calculates the highest_total_score' do
    expect(@stat_tracker.highest_total_score).to eq(5)
  end

  it 'calculates the lowest_total_score' do
    expect(@stat_tracker.lowest_total_score).to eq(3)
  end

  it 'calculates the percentage of home wins' do
    expect(@stat_tracker.percentage_home_wins).to eq(0.60)
  end

  it 'calculates the percentage of visitor wins' do
    expect(@stat_tracker.percentage_visitor_wins).to eq(0.40)
  end

  it 'calculates the percentage of ties' do
    expect(@stat_tracker.percentage_ties).to eq(0.0)
  end

  it 'calculates the count of games by season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({ '20122013' => 5 })
  end

  it 'calculates the average goals per game' do
    expect(@stat_tracker.average_goals_per_game).to eq(4.4)
  end

  it 'calculates the average goals by season' do
    expect(@stat_tracker.average_goals_by_season).to eq({ '20122013' => 4.4 })
  end

  # Team Statistics

  it 'calculates the highest scoring visitor team' do
    expect(@stat_tracker.highest_scoring_visitor_team).to eq('LA Galaxy')
  end

  it 'calculates the highest scoring home team' do
    expect(@stat_tracker.highest_scoring_home_team).to eq('LA Galaxy')
  end

  it 'calculates the lowest scoring home team' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq('Portland Timbers')
  end

  it 'calculates the lowest scoring visitor team' do
    expect(@stat_tracker.lowest_scoring_visitor_team).to eq('Portland Timbers')
  end

  it 'calculates the winningest team' do
    expect(@stat_tracker.winningest_team).to eq('LA Galaxy')
  end

  # Season Statistics
  it 'calculates the winningest coach for a season' do
    expect(@stat_tracker.winningest_coach('20122013')).to eq('Claude Julien')
  end

  it 'calculates the worst coach for a season' do
    expect(@stat_tracker.worst_coach('20122013')).to eq('John Tortorella')
  end

  it 'calculates the most accurate team for a season' do
    expect(@stat_tracker.most_accurate_team('20122013')).to eq('LA Galaxy')
  end

  it 'calculates the least accurate team for a season' do
    expect(@stat_tracker.least_accurate_team('20122013')).to eq('Portland Timbers')
  end

  it 'calculates the most tackles in a season' do
    expect(@stat_tracker.most_tackles('20122013')).to eq('LA Galaxy')
  end

  it 'calculates the fewest tackles in a season' do
    expect(@stat_tracker.fewest_tackles('20122013')).to eq('Portland Timbers')
  end

end
