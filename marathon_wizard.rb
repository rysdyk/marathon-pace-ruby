require './marathon_analysis'

p "Do you have (1) marathon finish time; or (2) marathon mile pace; or (3) other time/distance. (Enter Number)"
input = gets.chomp

def guide(input)
  if input == "1"
    puts "Enter your finish time: (ex: 'H:MM:SS') "
    finish_time = gets.chomp
    finish_time_to_splits(finish_time)
  end

  if input == "2"
   puts "what is your mile time? ex: 'H:MM:SS' "
   mile_time = gets.chomp
   mile_pace(mile_time)
   puts @time
  end

  if input == "3"
    puts "Please enter your finish time: (ex: 'H:MM:SS')"
    finish = gets.chomp
    puts "Please enter the distance in miles:"
    distance = gets.chomp
    pace(finish, distance.to_f)
    puts "#{@pace} / mile"
  end
end

guide(input)

while true
  puts "would you like to continue? (y/n)"
  input = gets.chomp
  if input == "y" || input == "yes"
    puts "Do you have marathon finish time (1) or marathon mile pace (2) or other distance (3)."
    num = gets.chomp
    guide(num)
  else
    puts "Thank you."
    exit
  end
end

if input == 'exit' || input == 'quit'
  exit
end
