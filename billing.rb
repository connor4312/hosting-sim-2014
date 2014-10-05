require_relative 'app'


class Billing

    @@app = App.instance

    def initialize
        bill()
    end

    def bill
        @last_bill = @@app.get "day"
        @@app.add "money", -@cost
    end

    def tick
        @@app.normalize_to 'glamour', @glamour, 0.5
        @@app.normalize_to 'satisfaction', @quality, 0.5

        if @last_bill + 30 <= @@app.get("day")
            bill()
        end

        @death_in -= 1
        if @death_in == 0
            @@app.push_screen "Your domain has been shut down for running a pirated billing instance. Most of your clients leave due to the instability, and you spend your remaining funds getting back and set up again.", {
                "Oh. Okay. (-90% clients, -100% money)" => Proc.new{}
            }
            @@app.update "clients", (@@app.get("clients").to_f * 0.9).floor
            @@app.update "money", 0
        end
    end
end

class WHMCS < Billing
    def initialize(pirated=false)
        @quality = 85
        @shit_chance = 3
        @glamour = 70
        @cost = if pirated then 0 else 15 end
        @death_in = if pirated then 7 + (rand() * 30.0).floor else -1 end

        super()
    end
end

class Blesta < Billing
    def initialize(pirated=false)
        @quality = 100
        @shit_chance = 1
        @glamour = 50
        @cost = if pirated then 0 else 13 end
        @death_in = if pirated then 7 + (rand() * 30.0).floor else -1 end

        super()
    end
end

class SelfCash < Billing
    def initialize
        @quality = 10
        @shit_chance = 10
        @glamour = 0
        @cost = 0
        @death_in = -1

        super()
    end
end
