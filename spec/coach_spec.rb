require_relative 'spec_helper'

RSpec.describe Coach do
  before(:each) do
    @coach = Coach.new("Logan")
  end

  it 'exists' do
    expect(@coach).to be_a Coach
  end

  it 'has attributes' do
    expect(@coach.name).to eq("Logan")
    expect(@coach.games_lost).to eq(0)
    expect(@coach.games_won).to eq(0)
  end
end