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

class OVH < Host
    def initialize
        @quality = 85
        @uptime = 99.9
        @dos_chance = 2
        @shit_chance = 3
        @glamour = 60
        @cost = 42

        super()
    end
end

class HomeHost < Host
    def initialize
        @quality = 20
        @uptime = 80
        @dos_chance = 10
        @shit_chance = 10
        @glamour = 25
        @cost = 0

        super()
    end
end

class Datashack < Host
    def initialize
        @quality = 60
        @uptime = 97
        @dos_chance = 4
        @shit_chance = 5
        @glamour = 40
        @cost = 34

        super()
    end
end

class Colocrossing < Host
    def initialize
        @quality = 40
        @uptime = 95
        @dos_chance = 6
        @shit_chance = 10
        @glamour = 30
        @cost = 40

        super()
    end
end
