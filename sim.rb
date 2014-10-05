require 'io/console'
require_relative 'app'
require_relative 'host'
require_relative 'billing'
require_relative 'panel'
require_relative 'customer'

app = App.instance

app.add_component Customer.new

options = Hash.new
options["Host from your home computer. (-$0 per month)"] = Proc.new{ app.add_component HomeHost.new }
options["Order an OVH server. (-$42 per month)"] = Proc.new{ app.add_component OVH.new },
options["Order a datashack server. (-$34 per month)"] = Proc.new{ app.add_component Datashack.new }
options["Order a ColoCrossing server. (-$40 per month)"] = Proc.new{ app.add_component Colocrossing.new }
options["Buy a Windows VPS from a shady guy from MCF. (-$8.99 per month)"] = Proc.new{ app.add_component MCF_WindowsVPS.new }
app.push_screen "You are 14 years old and want to start a hosting company. You have $100. How do you begin?", options


options = Hash.new
options["Get a WHMCS license. (-$15 per month)"] = Proc.new{ app.add_component WHMCS.new }
options["Pirate WHMCS. (-$0 per month)"] = Proc.new{ app.add_component WHMCS.new(true) }
options["Get a Blesta license. (-$13 per month)"] = Proc.new{ app.add_component Blesta.new },
options["Pirate Blesta. (-$0 per month)"] = Proc.new{ app.add_component WHMCS.new(true) }
options["Process payments yourself. (-$0 per month)"] = Proc.new{ app.add_component SelfCash.new }
app.push_screen "How are you going to handle billing?", options


options = Hash.new
options["Use Multicraft. (-$15/server/month)"] = Proc.new{ app.add_component Multicraft.new }
options["Use CraftSRV. (-$17 per month)"] = Proc.new{ app.add_component CraftSRV.new },
options["Use SpaceBukkit. (-$0 per month)"] = Proc.new{ app.add_component SpaceBukkit.new },
options["Wait for SpaceCP to come out. (+666 Days)"] = Proc.new{ app.add_component SpaceCP.new }
app.push_screen "What panel are you going to use to let clients control their servers?", options

app.show_screens

while true do
    app.pass_day
end
