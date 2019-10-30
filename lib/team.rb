class Team
  attr_reader :team_id,
    :abbreviation,
    :stadium,
    :link
    # :franchiseid

  def initialize(team_info)
    team_info.each do |key, value|
      instance_variable_set("@#{key}".downcase, value) unless value.nil?
    end
  end

  def franchise_id
    @franchiseid
  end

  def team_name
    @teamname
  end
end
