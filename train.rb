$LOAD_PATH << '.'
require 'menu'
require 'securerandom'
require 'byebug'

class Train

  attr_accessor :train_no, :name, :source,   :destination ,:route, :seats

  def initialize(train_no , name , source, destination, route, seats)
    @train_no = train_no
    @name = name
    @source = source
    @destination = destination
    @route = route
    @seats = seats
  end

  def create_train(trains)
    train_no = SecureRandom.uuid
    name = valid_input("Enter name of train:", "Please enter alphabatic name") {|input| input =~ /^[a-zA-Z\-\`]++(?: [a-zA-Z\-\`]++)?$/}
    source = valid_input("Enter source of train:", "Please enter alphabatic source") {|input| input =~ /^[a-zA-Z\-\`]++(?: [a-zA-Z\-\`]++)?$/}
    destination = valid_input("Enter destination of train:", "Please enter alphabatic destination") {|input| input =~ /^[a-zA-Z\-\`]++(?: [a-zA-Z\-\`]++)?$/}
    if train_exists?(trains, source, destination)
      puts "Train with source #{source} and destination #{destination} already exists."
      Menu.new.open_main_menu(trains)
    else
      route = valid_input("Enter route of train:", "Please enter alphabatic route") {|input| input =~ /^[a-zA-Z\-\`]++(?: [a-zA-Z\-\`]++)?$/}
      seats = valid_input("Enter seats of train: ", "Please enter a valid number of seats") { |input| input =~ /^\d+$/ }
      # byebug
      new_train = Train.new(@train_no = train_no,@name = name, @source = source, @destination = destination, @route = route, @seats = seats)
      trains[new_train.train_no] = new_train 
      trains
    end
  end

  def get_train(trains)
    trains.each_value do |train|
      puts " TRAIN_NUMBER : #{train.train_no} \n NAME : #{train.name} \n SOURCE : #{train.source} \n DESTINATION : #{train.destination} \n ROUTE : #{train.route} \n SEATS : #{train.seats} \n \n"
    end
  end

  def search_by_source(trains)
    source = valid_input("Enter source of train:", "Please enter alphabatic source") {|input| input =~ /^[a-zA-Z\-\`]++(?: [a-zA-Z\-\`]++)?$/}
   result = trains.values.select { |train| train.source.include?(source) }
   display_search_results(result)
  end

 def search_by_destination(trains)
  destination = valid_input("Enter destination of train:", "Please enter alphabatic destination") {|input| input =~ /^[a-zA-Z\-\`]++(?: [a-zA-Z\-\`]++)?$/}
  result = trains.values.select { |train| train.destination.include?(destination) }
  display_search_results(result)
 end

  def book_tickets(trains)
    puts "Enter the train number of the train to book tickets:"
    train_no = gets.chomp
    return book_tickets(trains) if train_no == nil || train_no == ""
    if trains[train_no]
      available_seats = trains[train_no].seats.to_i
      puts "Enter number of tickets to book:"
      number_of_people = gets.chomp.to_i
      return nil if number_of_people > available_seats
      available_seats >= number_of_people 
      trains[train_no].seats = (available_seats - number_of_people)
      puts "#{number_of_people} tickets booked successfully. #{available_seats - number_of_people} seats remaining."
    else
      puts "Train number #{train_no} does not exist."
    end
  end

  private

  def valid_input(msg, error_msg)
    loop do 
      puts msg
      input = gets.chomp
      return input if yield(input)
      puts error_msg
    end
  end

  def train_exists?(trains, source, destination)
   return nil if trains.empty?
   trains.each_value do |train| 
     return true if train.source == source && train.destination ==
     destination
   end
   false
  end

  def display_search_results(result)
   puts "No trains found with this data ." if result.empty?
   result.each do |train|
    puts " TRAIN_NUMBER : #{train.train_no} \n NAME : #{train.name} \n SOURCE : #{train.source} \n DESTINATION : #{train.destination} \n ROUTE : #{train.route} \n SEATS : #{train.seats} \n \n"
   end
  end
end
