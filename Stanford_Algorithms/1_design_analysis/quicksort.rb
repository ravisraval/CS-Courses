def quicksort(arr, comps)
  return [arr, comps] if arr.length <= 1
  # swap mid with first
  if arr.length.even?
    k = (arr.length / 2 - 1)
    v = arr[arr.length / 2 - 1]
  else
    k = (arr.length / 2)
    v = arr[arr.length / 2]
  end
  pivots = {
    0 => arr.first,
    k => v,
    arr.length - 1 => arr.last
  }
  idx = pivots.sort_by { |k, v| v }[1][0]
  # idx = rand(arr.length)
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
  comps += arr.length - 1
  # put pivot back
  arr[0], arr[i - 1] = arr[i - 1], arr[0]

  arr[0...i - 1], comps = quicksort(arr[0...i - 1], comps)
  arr[i..-1], comps = quicksort(arr[i..-1], comps)
  [arr, comps]
end

new_arr = open('./QuickSort.txt').each_line.map { |line| line.chomp.to_i }
p quicksort(new_arr, 0)
