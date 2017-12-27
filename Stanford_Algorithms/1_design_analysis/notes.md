merge sort has 6nlog(2)n + 6n operations

## Guiding principles of algo analysis
1. use worst-case analysis, as opposed to average-case and benchmarks (generally agreed upon, practical inputs)
2. won't pay attention to constant or lower-order terms
3. Asymptotic analysis - look at large input sizes

- as computers get faster, we'll try to solve tougher problems, and therefore algo analysis is actually more important the faster computers get

Asymptotic analysis: suppress constant factors and lower-order terms

## Divide and conquer paradigm
1. DIVIDE into smaller subproblems
2. CONQUER via recursive calls
3. COMBINE solution of subproblems into use for the original problem

#### Split inversions

 Split inversions cool thing: the split inversions involving an element X of the 2nd array == the numbers left in the 1st Array when merging X into the result array.

Basically, do merge sort, but:
- while merging the two sorted subarrays, keep running total of number of split inversions
- when element of 2nd array gets copied to output, increment total by remaining length of 1st array

Run time of subroutine: O(n) [merge] + O(n) [running total] = O(n)

This subroutine, (sort_and_count) runs log(n) times.
