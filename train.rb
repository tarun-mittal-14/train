$LOAD_PATH << '.'
require 'menu'
require 'securerandom'
require 'byebug'

class Train


  attr_reader :train_no, :name, :source,   :destination ,:route, :seats

  def initialize(train_no = "we1", name = "test" , source = "src1", destination = "des1", route = "route1", seats = 0)
    @train_no = train_no
    @name = name
    @source = source
    @destination = destination
    @route = route
    @seats = seats
  end

  def create_train(trains)
    train_no = SecureRandom.uuid
    puts "enter name of train: "
    name = gets.chomp
    puts "Enter source of train: "
    source = gets.chomp
    puts "Enter destination of train: "
    destination = gets.chomp
    if train_exists?( trains, source, destination)
      puts "Train with source #{source} and destination #{destination} already exists."
      Menu.new.open_main_menu(trains)
    else
      puts "Enter route of train: "
      route = gets.chomp
      puts "Enter seats of train: "
      seats = gets.chomp.to_i
      new_train = Train.new(train_no, name, source, destination, route, seats)
      new_train
    end
  end


  def train_exists?(trains, source, destination)
    if trains.empty?
      return false
    elsif
     trains.each_value do |train| 
      byebug
      if train.source == source && train.destination == destination
        return true
      end
     end
    else
        return false
    end
  end

    def get_train(trains)
      trains.each_value do |train|
        puts " TRAIN_NUMBER : #{train.train_no} \n NAME : #{train.name} \n SOURCE : #{train.source} \n DESTINATION : #{train.destination} \n ROUTE : #{train.route} \n SEATS : #{train.seats} \n \n"
      end
    end

    def search_by_source(trains)
     puts "Enter the source to search for any train from that source:"
     source = gets.chomp
     result = trains.values.select { |train| train.source.include?(source) }
     display_search_results(result)
   end

   def search_by_destination(trains)
    puts "Enter the destination to search for any train to that destination:"
    destination = gets.chomp
    result = trains.values.select { |train| train.destination.include?(destination) }
    display_search_results(result)
  end

  def book_tickets(trains)
    puts "Enter the train number of the train to book tickets:"
    train_no = gets.chomp
    if trains[train_no]
      available_seats = trains[train_no].seats
      puts "Enter number of tickets to book:"
      number_of_people = gets.chomp.to_i
      if available_seats >= number_of_people
        trains[train_no].instance_variable_set(:@seats, available_seats - number_of_people)
        puts "#{number_of_people} tickets booked successfully. #{available_seats - number_of_people} seats remaining."
      else
        puts "Not enough seats available. Only #{available_seats} seats left."
      end
    else
      puts "Train number #{train_no} does not exist."
    end
  end

  def display_search_results(result)
    if result.empty?
      puts "No trains found with this data ."
    else
      puts "Trains found:"
      result.each do |train|
        puts " TRAIN_NUMBER : #{train.train_no} \n NAME : #{train.name} \n SOURCE : #{train.source} \n DESTINATION : #{train.destination} \n ROUTE : #{train.route} \n SEATS : #{train.seats} \n \n"
      end
    end
  end
end

    # hashh.each_value {|v|  if v.include?(source) && v.include?(destination)}