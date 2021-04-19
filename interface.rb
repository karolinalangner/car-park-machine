require_relative 'carpark_machine'

puts ""
puts "*** Welcome ***"
sleep(0.7)
puts ""
puts "1st hour = £3"
puts "Every extra minute after 1h = +1p"
puts ""
puts "Maximum stay: 24h. After this time your car will be towed."
puts ""
puts "Need help? Call: +44 800 700 600"
puts ""
sleep(0.7)
puts "Time in?"

time_in = gets.chomp

puts "Time out?"

time_out = gets.chomp

park = CarparkMachine.new(time_in, time_out)


def display(park)
    puts park.stay_in_hours
    puts "Cost: £#{park.output_cost}"
    puts "Insert coins/notes"
    payment_in = gets.chomp 
    puts park.ask_for_payment(payment_in)
    
    puts "."
    sleep(0.2)#
    puts "."
    sleep(0.1)
    puts "."
    sleep(0.1)
    puts ""
    puts park.give_change
    puts ""
    puts "Thank you. Have a nice day."
end

display(park)

