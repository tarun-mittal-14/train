$LOAD_PATH << '.'
require 'menu.rb'
require 'train.rb'


class Main
	def main_method
		trains = Hash.new
		menu = Menu.new
		menu.open_main_menu(trains)
	end
end

main = Main.new
main.main_method
