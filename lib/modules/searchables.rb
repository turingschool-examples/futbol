module Searchable

  def search(collection, search_type, search_metric)
    collection.send(search_type) {|obj| obj.send(search_metric)}
  end


end