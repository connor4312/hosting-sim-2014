require 'io/console'
require_relative 'app'
require_relative 'host'
require_relative 'customer'

app = App.instance

app.add_component Customer.new

options = Hash.new
options["Host from your home computer. (-$0 per month)"] = Proc.new{ app.add_component HomeHost.new }
options["Order an OVH server. (-$42 per month)"] = Proc.new{ app.add_component OVH.new },
options["Order a datashack server. (-$34 per month)"] = Proc.new{ app.add_component Datashack.new }

app.draw "You are 14 years old and want to start a hosting company. You have $100. How do you begin?", options

while true do
    app.pass_day
end