require_relative 'app'

class Customer

    @@app = App.instance
    @@money_per_client = 10

    def initialize
        @clients = []
    end

    def get_clout
        return @@app.get("clients").to_f * (@@app.get("satisfaction").to_f + @@app.get("glamour").to_f * 3) / (4 *  100) * 0.01
    end

    def add_client
        @@app.add "money", @@money_per_client
        @@app.add "clients", 1

        day = { "signup" =>  @@app.get("day") }
        @clients.push day
    end

    def promote
        more_clients = (get_clout() ** rand() + rand() ** 10).round

        more_clients.times do
            add_client()
        end

        @@app.add "day", 1
    end

    def advertise
        more_clients = (get_clout() * 2 ** rand() + rand() ** 6).round

        more_clients.times do
            add_client()
        end
        
        @@app.add "day", 1
    end

    def give_chargeback
        @@app.add "money", -@@money_per_client
    end

    def fight_chargeback
        @@app.add "satisfaction", -5

        if rand() > 0.5
            @@app.add "money", -@@money_per_client
        end
    end

    def tick
        options = {
            "Post on MinecraftForums. (+1 Day)" => Proc.new{ promote() },
            "Promote on social media. (+1 Day)" => Proc.new{ promote() },
            "Buy advertisements online. (+1 Day, -10% Cash)" => Proc.new{ advertise() },
        }
        @@app.push_screen "What do you want to do for your customers?", options

        @clients.each do |client|
            if @@app.get("day") > client["signup"] + 30
                if (@@app.get("satisfaction").to_f / 100) > rand()
                    @@app.add "money", @@money_per_client
                else
                    @@app.add "clients", -1
                end
            end

            if @@app.get("clients") > 0 and (@@app.get("satisfaction").to_f / 100) < rand() / 10
                @@app.add "clients", -1

                @@app.push_screen "A client filed a chargeback against you. What do you want to do?", {
                    "Fight it. (-5% Satisfaction, 50% chance of -$#{@@money_per_client})" => Proc.new{ fight_chargeback() },
                    "Concede to the chargeback. (-$#{@@money_per_client})" => Proc.new{ give_chargeback() }
                }
            end
        end
    end
end