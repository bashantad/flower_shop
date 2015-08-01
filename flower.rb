require_relative 'array'
require_relative 'error_classes'

# class to hold data and methods for flower shop
class Flower
  DATA = {
    :R12 => { :name => "Roses", :prices => { 5  => 6.99, 10 => 12.99 } },
    :L09 => { :name => "Lilies", :prices => { 3 => 9.95, 6 => 16.95, 9 => 24.95 } },
    :T58 => { :name => "Tulips", :prices => { 3  => 5.95, 5 => 9.95, 9 => 16.99 } }
  }

  def execute_script(input_string)
    input_data  = input_string.split(/\s+/)
    raise InvalidCommand.new unless input_data.length == 2
    number      = input_data[0].to_i
    code        = input_data[1].to_sym

    raise InvalidCommand.new if number < 1 || DATA.keys.include?(code) == false

    price_set          = DATA[code][:prices]
    output_bundle_set  = find_minimum_bundle(price_set.keys, number.to_i)
    format_output(price_set, output_bundle_set)
  end

  def find_minimum_bundle(array, number)
    raise InvalidData.new if array.is_a?(Array) == false || array.empty?
    raise InvalidData.new if number.is_a?(Integer) == false || number < 1

    possible_sets         = array.collect { |element| (0..number/element).to_a.product([element]) }.reverse
    possible_combinations = possible_sets[0].product(*possible_sets[1..-1])
    matched_combinations  = possible_combinations.select{ |combo| combo.collect(&:multiplication).sum == number }

    raise InvalidNumberOfFlower.new if matched_combinations.empty?
    matched_combinations.min_by{ |combo| sum_first_element_of_array(combo) }
  end

  def price_format(no_of_bundle, no_of_flower_per_bundle, price_set)
    "#{no_of_bundle} x #{no_of_flower_per_bundle} $#{price_set[no_of_flower_per_bundle]}"
  end

  def format_output(price_set, bundle_set)
    bundle_set.select!{ |set| set[0] != 0 }
    total_price = bundle_set.collect{ |set| set[0] * price_set[set[1]] }.sum.round(2)
    "$#{total_price}\n\t" + bundle_set.collect{ |set| price_format(set[0], set[1], price_set) }.join("\n\t")
  end

  def sum_first_element_of_array(combination)
    combination.collect{ |set| set[0] }.sum
  end

end