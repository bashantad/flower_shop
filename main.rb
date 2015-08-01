require_relative './flower'
begin
  flower = Flower.new
  puts "Enter appropriate commands"
  puts "Type EXIT to get out of the program"
  input_string = ""

  while input_string != "EXIT"
    input_string = STDIN.gets.strip
    output = flower.execute_script(input_string)
    puts output if output != nil
  end

rescue InvalidCommand
  puts "Please enter proper command"
rescue InvalidData
  puts "Please enter valid data"
rescue InvalidNumberOfFlower
  puts "Can't bundle due to wrong number of flowers"
rescue Exception => e
  puts "Error : #{e.message}"
end