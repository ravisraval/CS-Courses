def quicksort(arr)
  return arr if arr.length <= 1
  # swap mid with first
  arr[arr.length/2], arr[0] = arr[0], arr[arr.length / 2]
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

p quicksort([3, 1, 8, 5, 4, 2, 7, 6, 0, 4])
