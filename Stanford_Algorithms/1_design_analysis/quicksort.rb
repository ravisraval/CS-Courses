def quicksort(arr)
  return arr if arr.length <= 1
  # swap mid with first
  # idx = 0
  idx = rand(arr.length)
  # loop do
  #   break if arr[idx] > arr[idx + 1]
  #   idx += 1
  #   return arr if idx == arr.length - 1
  # end
  arr[idx], arr[0] = arr[0], arr[idx]
  # arr[arr.length / 2], arr[0] = arr[0], arr[arr.length / 2]
  pivot = arr[0]
  j = i = 1

  until j == arr.length
    to_move = arr[j]

    if to_move < pivot
      arr[i], arr[j] = arr[j], arr[i]
      i += 1
    end
    j += 1
  end
  #put pivot back
  arr[0], arr[i - 1] = arr[i - 1], arr[0]

  arr[0...i - 1] = quicksort(arr[0...i - 1])
  arr[i..-1] = quicksort(arr[i..-1])

  arr
end



a = Time.now
100000.times do |t|
  quicksort([3, 1, 8, 5, 4, 2, 7, 6, 0, 4, 10, 52, 42, 13, 2, 26, 94, 75])
end
puts Time.now - a
