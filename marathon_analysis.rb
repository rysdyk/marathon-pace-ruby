require 'time'

# if marathon time, here are your splits and goal estimates
# if mile pace, here is your finish time and goal estimates

# irb -r ./marathon_analysis.rb
# once in irb: load './marathon_analysis.rb'

#get mile avg based on final time.
def average_mile(finish_time)
  raise ArguementError, "Please submit a valid finish time ('H:MM:SS')" unless Time.parse(finish_time)

  t = Time.parse(finish_time)
  total_seconds(t)
  seconds_per_mile(@seconds)
  minutes = @seconds_per_mile / 60
  decimal_to_seconds(minutes)
end

# convert decimals (8.5 minutes) into seconds (08:30)
def decimal_to_seconds(x)
  y = x % 1
  y = y * 60
  z = y % 1 * 10  # this adds decimal to time -- still need to decide whether to keep this
  return "#{sprintf("%02d", x.floor)}:#{sprintf("%02d", y)}.#{z.round}"
end

# calculate per mile splits of marathon
def splits(marathon_time)
  raise ArgumentError, "Time format should be 'H:MM:SS' or 'H:MM'" unless Time.parse(marathon_time)

  generate_splits(26.2)

  t = Time.parse(marathon_time)
  total_seconds(t)
  seconds_per_mile(@seconds)

  @splits.each do |m|
    time = m.to_f * @seconds_per_mile.to_f
    minutes = time / 60
    minute = minutes.floor
    seconds = minutes % 1
    pace = "#{minute/60 % 60}:#{ sprintf("%02d", minute % 60) }:#{sprintf("%02d", (seconds * 60).floor )}"

    puts "#{m} - #{pace}"

  end
end

# combines splits and average mile
def finish_time_to_splits(result)
  splits(result)
  average = average_mile(result)
  puts "Average mile time: #{average}"
end

# takes mile pace and figures out total marathon finish time
# 00:08:30
def mile_pace(mile_time)
  # requires hour in mile time
  t = Time.parse(mile_time)
  # convert minutes into seconds
  total_seconds(t)
  total_seconds = @seconds * 26.2
  total_minutes = total_seconds / 60
  hours = (total_minutes / 60).floor
  minutes = (total_minutes % 60).floor
  seconds = total_minutes % 1
  seconds = (60 * seconds).round
  # the fast way to do all of that
  # time = Time.at(total_seconds).utc.strftime("%H:%M:%S")
  time = "#{sprintf("%02d", hours)}:#{sprintf("%02d", minutes)}:#{sprintf("%02d", seconds)}"
  @time = time
  return time
  # splits(marathon_time)
end

# takes total time for any event and returns mile pace
def pace(finish_time, distance)

  raise ArgumentError, "Finish time format should be 'H:MM:SS' or 'H:MM'" unless Time.parse(finish_time)
  raise ArgumentError, "distance should be a number" unless distance.is_a?(Numeric)

  t = Time.parse(finish_time)
  total_seconds(t)
  seconds = @seconds / distance
  mile_minutes = (seconds / 60).floor
  mile_seconds = (seconds / 60) % 1
  mile_seconds = 60 * mile_seconds
  pace = "#{sprintf("%02d", mile_minutes)}:#{sprintf("%02d", mile_seconds.round)}"
  @pace = pace
  return "#{pace} per mile"
  # if distance is array, returns out splits
end

def total_seconds(time)
  @seconds = time.hour * 3600 + time.min * 60 + time.sec
end

def seconds_per_mile(seconds)
  @seconds_per_mile = seconds / 26.2
end

def generate_splits(distance)
  splits = (0..distance).to_a

  if distance >= 13.1
    splits.insert(14, 13.1)
  end

  if distance >= 26.2
    splits.insert(28, 26.2)
  end

  @splits = splits
end

#def goals
  # how much faster to mile to reach next round number?
  # how much faster per mile to finish 10 minutes faster
    # hint: 23 seconds per mile to finish 10 minutes faster
#end

# add raise exceptions if numbers not right...

# note that these are estimates since half a second per mile over a marathon is 13 seconds.

# realistic split difference aka mile 1 will be faster than mile 26
