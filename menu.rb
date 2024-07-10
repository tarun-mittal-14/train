$LOAD_PATH << '.'
require 'train.rb'
require 'byebug'

class Menu
  def open_main_menu(trains)
    puts "Enter your choice"
    puts "1 Create train"
    puts "2 view trains"
    puts "3 view trains by source"
    puts "4 view trains by destination"
    puts "5 book tickets"
    puts "6 Exit "
    puts
    choice = gets.chomp.to_i
    case choice
    when 1
      # byebug
       # Train.new(train_no, name, source, destination, route, seats)
      # new_train = Train.new.create_train(trains,  train_no,name, source, destination,  route,  seats)
     new_train =  Train.new(@train_no, @name, @source, @destination,  @route,  @seats).create_train(trains)
      # trains[new_train.train_no] = new_train 
      open_main_menu(trains)
    when 2
      view_train = Train.new(@train_no, @name, @source, @destination,  @route,  @seats).get_train(trains)
      open_main_menu(trains)
    when 3
      view_train = Train.new(@train_no, @name, @source, @destination,  @route,  @seats).search_by_source(trains)
      open_main_menu(trains)
    when 4
      view_train = Train.new(@train_no, @name, @source, @destination,  @route,  @seats).search_by_destination(trains)
      open_main_menu(trains)
    when 5
      view_train = Train.new(@train_no, @name, @source, @destination,  @route,  @seats).book_tickets(trains)
      open_main_menu(trains)
    when 6
      puts "Exiting....."
      exit
    else
      puts "Please Enter valid choice"
      open_main_menu(trains)
    end
  end
end
