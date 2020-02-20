module Calculable

  def sort(class_object)
    total_scores = []
    class_object.all.each_value do |value|
      total_scores << value.home_goals + value.away_goals
    end
    total_scores.uniq.sort
  end

end
