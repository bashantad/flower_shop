require './flower'

RSpec.describe  Flower do

  let(:flower) { Flower.new }

  describe "#sum_first_element_of_array" do

    it "finds sum of first element of each array inside an array" do
      array = [[2, 9], [1, 5], [4, 7]]
      expect(flower.sum_first_element_of_array(array)).to eq(7)
    end

  end

  describe "#find_minimum_bundle" do

    context "When array is empty" do

      it "raises InvalidData exception" do
        expect { flower.find_minimum_bundle([], 2) }.to raise_error(InvalidData)
      end

    end

    context "When number is less than 1" do

      it "raises InvalidData exception" do
        expect { flower.find_minimum_bundle([1,2,5], 0) }.to raise_error(InvalidData)
      end

    end

    context "When proper combination is not given" do

      it "raises InvalidNumberOfFlower exception" do
        expect{
          flower.find_minimum_bundle([4,5,6], 7)
        }.to raise_error(InvalidNumberOfFlower)
      end

    end

    context "When proper combination is given" do

      it "it returns minimum combination" do
        bundle_set = flower.find_minimum_bundle([3,6], 15)
        expect(bundle_set).to eq [[2, 6], [1, 3]]
      end

    end

  end


  describe "#price_format" do

    it "returns formatted no of bundle and price" do
      expect(flower.price_format(2, 5, {5 => 10})).to eq "2 x 5 $10"
    end

  end

  describe "#format_output" do

    it "returns formatted output" do
      bundle_price = {3 => 9.95, 6 => 16.95}
      bundle_set   = [[2, 6], [1, 3]]
      expect(flower.format_output(bundle_price, bundle_set)).to eql "$43.85\n\t2 x 6 $16.95\n\t1 x 3 $9.95"
    end

  end


  describe "#execute_script" do

    context "When valid input are given" do

      ["5 R12", "6   L09", "9  T58"].each do |input_string|

        it "doesn't throw an exception for input_string : #{input_string}" do
          expect{
            flower.execute_script(input_string)
          }.to_not raise_error
        end

      end

    end

    context "When invalid input is given" do

      ["R124 Roses", "two L09", "4 Tulips6"].each do |input_string|

        it "throws an exception for input_string:  #{input_string}" do
          expect{
            flower.execute_script(input_string)
          }.to raise_error InvalidCommand
        end

      end

    end

    context "Integration Specs" do

      it "bundle set for 10 Roses is $12.99\n\t1 x 10 $12.99" do
        expect(flower.execute_script("10 R12")).to eq "$12.99\n\t1 x 10 $12.99"
      end

      it "bundle set for 25 Roses is $32.97\n\t2 x 10 $12.99\n\t1 x 5 $6.99" do
        expect(flower.execute_script("25 R12")).to eq "$32.97\n\t2 x 10 $12.99\n\t1 x 5 $6.99"
      end

      it "bundle set for 15 Lilies is $41.9\n\t1 x 9 $24.95\n\t1 x 6 $16.95" do
        expect(flower.execute_script("15 L09")).to eq "$41.9\n\t1 x 9 $24.95\n\t1 x 6 $16.95"
      end

      it "bundle set for 27 Lilies is $91.8\n\t3 x 9 $24.95\n\t1 x 6 $16.95" do
        expect(flower.execute_script("33 L09")).to eq "$91.8\n\t3 x 9 $24.95\n\t1 x 6 $16.95"
      end

      it "bundle set for 13 Tulips is $25.85\n\t2 x 5 $9.95\n\t1 x 3 $5.95" do
        expect(flower.execute_script("13 T58")).to eq "$25.85\n\t2 x 5 $9.95\n\t1 x 3 $5.95"
      end

      it "bundle set for 22 Tulips is $42.84\n\t1 x 9 $16.99\n\t2 x 5 $9.95\n\t1 x 3 $5.95" do
        expect(flower.execute_script("22 T58")).to eq "$42.84\n\t1 x 9 $16.99\n\t2 x 5 $9.95\n\t1 x 3 $5.95"
      end

    end

  end

end