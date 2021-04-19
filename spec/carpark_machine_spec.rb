require_relative "../carpark_machine"

describe "#stay_in_hours" do
    it "Returns time of customer's stay in the carpark in hours and minutes" do
        park_a_car = CarparkMachine.new("10:00", "11:02")
        actual = park_a_car.stay_in_hours
        expected = "Total time: 1h 2min" 

        expect(actual).to eq(expected)
    end
end

describe "#output_cost" do
    it "Returns cost of the service when stay is 1 h" do
        park_a_car = CarparkMachine.new("10:00", "11:00")
        actual = park_a_car.output_cost
        expected = 3 

        expect(actual).to eq(expected)
    end
    it "Returns cost of the service" do
        park_a_car = CarparkMachine.new("10:00", "11:02")
        actual = park_a_car.output_cost 
        expected = 3.02 

        expect(actual).to eq(expected)
    end
end

describe "#ask_for_payment" do
  
    it "Returns users's current balance" do
        park_a_car = CarparkMachine.new("10:00", "11:00")
        actual = park_a_car.ask_for_payment("£1, £1, £1")
        expected ="Balance: £3.0"

        expect(actual).to eq(expected)
    end   
end

describe "#give_change" do
    it "Calculates due change and outputs the amount in the least amount of coins/notes" do  
        park_a_car = CarparkMachine.new("9:06", "10:17")
        park_a_car.ask_for_payment("£5")
        actual = park_a_car.give_change
        expected = "Coins: £1, 50p, 20p, 10p, 5p, 2p, 2p"

        expect(actual).to eq(expected)    
    end
    it "Returns £5, 50p, 20p, 10p, 5p for stay between 16:14 and 19:09 and payment of £10" do  
        park_a_car = CarparkMachine.new("16:14", "19:09")
        park_a_car.ask_for_payment("£10")
        actual = park_a_car.give_change
        expected = "Notes: £5. Coins: 50p, 20p, 10p, 5p"

        expect(actual).to eq(expected)    
    end 
end