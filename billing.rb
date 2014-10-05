require_relative 'app'


class Host

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
    end
end

class WHMCS < Host
    def initialize
        @quality = 85
        @shit_chance = 3
        @glamour = 70
        @cost = 15

        super()
    end
end

class Blesta < Host
    def initialize
        @quality = 100
        @shit_chance = 1
        @glamour = 50
        @cost = 13

        super()
    end
end

class SelfCash < Host
    def initialize
        @quality = 10
        @shit_chance = 10
        @glamour = 0
        @cost = 0

        super()
    end
end
