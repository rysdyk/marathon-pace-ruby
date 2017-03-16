require './marathon_analysis'

p "Do you have marathon finish time (1) or marathon mile pace (2) or other distance (3)"
input = gets.chomp

if input == "1"
  puts "what is your finish time? (HH:MM:SS)"
  finish_time = gets.chomp
  finish_time_to_splits(finish_time)
end

if input == "2"
 puts "what is your mile time? (HH:MM:SS)"
 mile_time = gets.chomp
 mile_pace(mile_time)
 puts @time
end

if input == "3"
  puts "Please enter your finish time:"
  finish = gets.chomp
  puts "Please enter the distance in miles:"
  distance = gets.chomp
  pace(finish, distance.to_f)
  puts "#{@pace} / mile"
end
