arr = [1, 2, 3, 3, 2, 1]

=begin
set a array to hold all subarrays
set idx to 0
while idx is less than array size
  set temp array for current subarray
  until array at index location is included in temp array
    push current idx element of array into temp
    add one to temp
  push temp array into subarrays

sum the subarrays in subarrays
return max value
=end

arr = [1, 2, 3, 3, 2, 1]

def get_uniq_max_sum(arr)
  subs = []
  idx = 0
  while idx < arr.size
    temp = []
    until temp.include?(arr[idx])
      temp << arr[idx]
      idx += 1
      break if idx == arr.size
    end
    subs << temp
  end
  subs.map(&:sum).max
end

p get_uniq_max_sum(arr)