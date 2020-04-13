module Mathable

  def percentage(type_of_wins, type_of_list)
    # type_of_list = Type.new(collection)
    ((type_of_wins.to_f / type_of_list.length.to_f)).round(2)
  end

  def average(collection)
    (collection.sum / collection.length.to_f).round(2)
  end

  def average2(collection1, collection2)
    (collection1.sum / collection2.length.to_f).round(2)
  end

end
