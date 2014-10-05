require 'io/console'
require 'singleton'

def wrap(s, width=78)
    s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
end

class App
    include Singleton

    def initialize
        @height, @width = IO.console.winsize

        @components = []
        @screens = []
        @normalization = {}
        @props = {
            "money" => 100,
            "day" => 0,
            "clients" => 1,
            "tickets" => 0,
            "satisfaction" => 100,
            "glamour" => 10
        }
    end

    def push_screen(questions, options)
        @screens.push [questions, options]
    end

    def get(prop)
        return @props[prop]
    end

    def normalize_to(prop, value, weight)
        if not @normalization.has_key? prop
            @normalization[prop] = []
        end

        @normalization[prop].push [value, weight]
    end

    def update(prop, value)
        @props[prop] = value
    end

    def add(prop, value)
        @props[prop] = get(prop) + value
    end

    def add_component(component)
        @components.push component
    end

    def remove_component(component)
        @components.delete component
    end

    def show_screens
        @screens.each do |screen|
            draw screen[0], screen[1]
        end

        @props.each do |key, value|
            if key == "money" and value < 0
                puts "You're broke, kid, game over!"
                exit
            end
            if key == "clients"
                value = [value, 0].max
            end

            @props[key] = value
        end

        @normalization.each do |key, normalizes|
            total = normalizes.reduce(1) { |sum, obj| sum + obj[1] }
            out = 0
            normalizes.each do |value|
                out += value[0] * value[1] / total
            end

            @props[key] = out.round
        end
    end

    def pass_day
        @normalization = {}
        @screens = []

        @components.each do |component|
            component.tick
        end

        show_screens()
    end


    def output(line)
        out = wrap(line, @width).chomp
        puts out
        @lines += 1 + out.count("\n") 
    end

    def draw_head
        output " Hosting Simulator 2014 ".center @width - 1, "="

        @props.each do |key, value|
            output ("#{key}: #{value}").center @width - 1
        end
    end

    def draw_to_end
        (@height - @lines - 1).times do
            puts ""
        end
    end

    def draw(question, options)
        @lines = 0

        draw_head()

        output ""
        output " " * 4 + question
        output ""

        options = options.to_a

        options.each_index do |index|
            output " [#{index}] " + options[index][0]
        end

        draw_to_end()
        option = gets
        options[option.to_i][1].call
    end
end