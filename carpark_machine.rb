require 'time'

class CarparkMachine

    attr_accessor :time_in, :time_out, :balance, :stay

    def initialize(time_in, time_out)
        @time_in = Time.parse(time_in)
        @time_out = Time.parse(time_out)
        @stay = calculate_stay
        @balance = []
    end

    def stay_in_hours 
        hours = @stay / 60
        rest = @stay % 60

        return "Total time: #{hours}h #{rest}min"
    end

    def output_cost
        if @stay > 1
            extra_minutes = (@stay - 60)
            cost = 3 + (extra_minutes / 100.00).ceil(2)
            return cost
        else
            return 3
        end
    end

    def ask_for_payment(payment_in)
        add_balance(payment_in)
        
        while @balance.sum < output_cost
            puts "Balance remaining: £#{(output_cost.to_f-@balance.sum).round(2)}"
            puts "Insert more coins/notes"
            payment_in = gets.chomp 
            add_balance(payment_in)
        end
        return "Balance: £#{@balance.sum}"
    end

    def give_change
        available_denominations  = [2000, 1000, 500, 100, 50, 20, 10, 5, 2, 1]
        change = []
        cost = output_cost.to_f
        change_due = ((@balance.sum - cost) * 100).to_int
        if change_due > 0
            puts "Change due: #{beautify_amount(change_due)}"
            available_denominations.select do |denomination|      
                while ((change_due/denomination).to_int > 0)
                    (change_due/denomination).to_int.times do
                        change << denomination 
                        change_due -= denomination
                    end
                end        
            end

            coins_beautified = []
            notes_beutified = []

            change.each do |denomination|
                if denomination <= 100
                    coins_beautified << beautify_change(denomination)
                else
                    notes_beautified << beautify_change(denomination)
                end             
            end
            if notes_beutified.empty?
                return "Coins: #{coins_beautified.join(", ")}"
            else
                return "Notes: #{notes_beautified.join(", ")}. Coins: #{coins_beautified.join(", ")}"  
            end
        end    
    end

    private

    def calculate_stay 
        @stay = ((@time_out - @time_in) / 60).to_i
        if @stay < 0
            @stay = 1440 - @stay *(-1)
        end
        return @stay
    end

    def beautify_change(change)
        "#{ '£' if change >= 100 }#{ change >= 100 ? change.to_int/100 : change.to_int}#{ 'p' if change < 100 }"
    end

    def beautify_amount(amount)
        "#{ '£' if amount >= 100 }#{ amount >= 100 ? amount.to_f/100 : amount.to_int}#{ 'p' if amount < 100 }"
    end

    def add_balance(payment_in)
        @balance << payment_in.split(", ").map { |n| 
        if n[0] == "£" 
            n.split(/[^\d]/).join.to_f
        else 
            n.split(/[^\d]/).join.to_f / 100.00
        end
        }.sum
        
    end
end
