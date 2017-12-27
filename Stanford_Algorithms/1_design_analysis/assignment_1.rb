# This file contains all of the 100,000 integers between 1 and 100,000 (inclusive) in some order, with no integer repeated.
#
# Your task is to compute the number of inversions in the file given, where the ith row of the file indicates the ith entry of an array.
#
# Because of the large size of this array, you should implement the fast divide-and-conquer algorithm covered in the video lectures.
#
# The numeric answer for the given input file should be typed in the space below.
#
# So if your answer is 1198233847, then just type 1198233847 in the space provided without any spaces or commas or any other punctuation marks. You can make up to 5 attempts.
#
# (We do not require you to submit your code, so feel free to use any programming language you want --- just type the final numeric answer in the following space.)
#
# [TIP: before submitting, first test the correctness of your program on some small test files or your own devising. Then post your best test cases to the discussion forums to help your fellow students!]

def get_inversions(arr)
  return arr if arr.length <= 1

  pivot = arr.length / 2

  sorted_left = get_inversions(arr[0...pivot])
  sorted_right = get_inversions(arr[pivot..-1])

  return merge(sorted_left, sorted_right)
end

def merge(left, right, inversions = 0)
  p left
  p right
  result_arr = []

  left_idx = 0
  right_idx = 0

  until left_idx == left.length || right_idx == right.length
    if left[left_idx] < right[right_idx]
      result_arr.push(left[left_idx])
      left_idx += 1
    else
      result_arr.push(right[right_idx])
      right_idx += 1
      inversions += 1
    end
  end

  if right_idx == right.length
    result_arr.concat(left[left_idx..-1])
  else
    result_arr.concat(right[right_idx..-1])
    inversions += left.length - left_idx
  end

  inversions
end

p get_inversions([1,2,3,4,5])
