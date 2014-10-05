require_relative 'app'


class Panel

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
        @@app.normalize_to 'satisfaction', @quality, 2

        if @last_bill + 30 <= @@app.get("day")
            bill()
        end
    end
end

class Multicraft < Panel
    def initialize
        @quality = 85
        @glamour = 75
        @cost = 15
        @haxed = if rand() > 0.25 then 15 + (rand() * 30.0).floor else -1 end

        super()
    end

    def tick
        @haxed -= 1

        if @haxed == 0
            @@app.push_screen "You forgot to remove access to the /protected directory in Multicraft! You got hacked and lost half your clients.", {
                "Oh. Okay. (-50% clients)" => Proc.new{}
            }
            @@app.update "clients", (@@app.get("clients") / 2).floor
        end

        super()
    end

    def bill
        @last_bill = @@app.get "day"
        @@app.add "money", -@cost * (@@app.get("clients").to_f / 10).ceil
    end
end

class CraftSRV < Panel
    def initialize
        @quality = 100
        @shit_chance = 1
        @glamour = 50
        @cost = 17

        super()
    end
end

class SpaceBukkit < Panel
    def initialize
        @quality = 100
        @shit_chance = 1
        @glamour = 50
        @cost = 13

        super()
    end
end

class SpaceCP < Panel
    def tick
        @@app.add "day", 666
    end
end
