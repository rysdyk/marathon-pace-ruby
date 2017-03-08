require 'time'

# 'would you like to enter mile pace or finish time?'
# get that time
# if marathon time, here are your splits and goal estimates
# if mile pace, here is your finish time and goal estimates

# irb -r ./marathon_analysis.rb

#get mile avg based on final time.
def average_mile(finish_time)
  t = Time.parse(finish_time)
  seconds = t.hour * 3600 + t.min * 60
  mile = seconds / 26.2
  minutes = mile / 60
  decimal_to_seconds(minutes)
end

# convert decimals into seconds
def decimal_to_seconds(x)
  y = x % 1
  y = y * 60
  return "#{sprintf("%02d", x.floor)}:#{sprintf("%02d", y.round(2))}"
end

# calculate per mile splits of marathon
def splits(marathon_time)
  miles = (0..26).to_a
  miles << 26.2
  miles.insert(14, 13.1)

  t = Time.parse(marathon_time)
  seconds = t.hour * 3600 + t.min * 60 + t.sec
  mile_seconds = seconds / 26.2

  miles.each do |m|
    time = m.to_f * mile_seconds.to_f
    minutes = time / 60
    minute = minutes.floor
    seconds = minutes % 1
    pace = "#{minute/60 % 60}:#{ sprintf("%02d", minute % 60) }:#{sprintf("%02d", (seconds * 60).floor )}"

    puts "#{m} - #{pace}"
  end
end

# takes finish time and prints out splits and average mile pace
def finish_time(result)
  splits(result)
  average = average_mile(result)
  puts "Average mile time: #{average}"
end

# takes mile pace and figures out total marathon finish time
def mile_pace(mile_time)
  # requires hour in mile time
  t = Time.parse(mile_time)
  # convert minutes into seconds
  mile_seconds = t.min * 60 + t.sec
  total_seconds = mile_seconds * 26.2
  total_minutes = total_seconds / 60
  hours = (total_minutes / 60).floor
  minutes = (total_minutes % 60).floor
  seconds = total_minutes % 1
  seconds = (60 * seconds).round
  # the fast way to do all of that
  # time = Time.at(total_seconds).utc.strftime("%H:%M:%S")
  time = "#{sprintf("%02d", hours)}:#{sprintf("%02d", minutes)}:#{sprintf("%02d", seconds)}"
  return time
  # splits(marathon_time)
end

# takes total time for any event and returns mile pace 
def pace(finish_time, distance)
  # takes finish_time of any distance and returns out mile pace
  t = Time.parse(finish_time)
  total_seconds = t.hour * 3600 + t.min * 60 + t.sec
  seconds = total_seconds / distance
  mile_minutes = (seconds / 60).floor
  mile_seconds = (seconds / 60) % 1
  mile_seconds = 60 * mile_seconds
  pace = "#{sprintf("%02d", mile_minutes)}:#{sprintf("%02d", mile_seconds.round)}"
  # if distance is array, returns out splits
end

#def goals
  # how much faster to mile to reach next round number?
  # how much faster per mile to finish 10 minutes faster
    # hint: 23 seconds per mile to finish 10 minutes faster
#end

# add raise exceptions if numbers not right...

# note that these are estimates since half a second per mile over a marathon is 13 seconds.

# realistic split difference aka mile 1 will be faster than mile 26
