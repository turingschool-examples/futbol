module MergeSort

  def merge_sort(array, sorting)
    if array.length > 1
      half = array.length / 2
      first = array.take(half)
      second = array.drop(half)
      array = merge(merge_sort(first, sorting), merge_sort(second, sorting),sorting)
    end

    array
  end

  def merge(array1, array2, sorting)
    merged = []
    while array1.any? && array2.any?
      if array1.first.send(sorting) < array2.first.send(sorting)
        merged.push(array1.shift)
      else
        merged.push(array2.shift)
      end
    end

    merged += array1
    merged += array2
  end


end