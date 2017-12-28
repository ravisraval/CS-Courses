# Download the following text file: algo1-programming_prob-2sum.txt
#
# The goal of this problem is to implement a variant of the 2-SUM algorithm (covered in the Week 6 lecture on hash table applications).
#
# The file contains 1 million integers, both positive and negative (there might be some repetitions!).This is your array of integers, with the ith row of the file specifying the ith entry of the array.
#
# Your task is to compute the number of target values t in the interval [-10000,10000] (inclusive) such that there are distinct numbers x,y in the input file that satisfy x+y=t. (NOTE: ensuring distinctness requires a one-line addition to the algorithm from lecture.)
#
# Write your numeric answer (an integer between 0 and 20001) in the space provided.
#
# OPTIONAL CHALLENGE: If this problem is too easy for you, try implementing your own hash table for it. For example, you could compare performance under the chaining and open addressing approaches to resolving collisions.

def sum2_variant(arr)
  target_count = 0
  num_hash = {}
  arr.each do |num|
    num_hash[num] = true
  end
  count = 0
  -10_000.upto(10_000).each do |t|
    puts t
    p target_count
    p "#{count.fdiv 20_000}%"
    num_hash.each_key do |k|
      target_count += 0.5 if num_hash.key?(t - k) && t - k != k
    end
    count += 1
  end

  target_count
end

read_arr = File.read('./algo1-programming_prob-2sum.txt')
               .each_line.map { |line| line.chomp.to_i }
p sum2_variant(read_arr)
