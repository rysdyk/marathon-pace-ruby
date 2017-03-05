require 'time'

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

def mile_pace(mile_time)
  # convert minutes into seconds
  t = Time.parse(mile_time)
  seconds = t.min * 60 + t.sec
  puts seconds

  # splits(marathon_time)
end

def finish_time(result)
  splits(result)
  average = average_mile(result)
  puts "Average mile time: #{average}"
end

#def goals
  # how much faster to mile to reach next round number?
  # how much faster per mile to finish 10 minutes faster
#end
