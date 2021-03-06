require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "Pillsbury") }
  let(:brownie) { Dessert.new("brownie", 50, chef)}
  # let(:chef) { double("chef", name: "Pillsbury") }


  describe "#initialize" do
    it "sets a type" do
      expect(brownie.type).to eq('brownie')
    end

    it "sets a quantity" do
      expect(brownie.quantity).to eq(50)
    end

    it "starts ingredients as an empty array" do
      expect(brownie.ingredients).to eq([])
    end

    context 'with a non-integer quantity' do
      subject(:brownie) { Dessert.new("brownie", "x", chef)}
      it "raises an argument error when given a non-integer quantity" do
        expect { brownie.quantity }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      brownie.add_ingredient("chocolate")
      expect(brownie.ingredients).to include("chocolate")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["chocolate", "eggs", "butter"]
      ingredients.each do |ingredient|
        brownie.add_ingredient(ingredient)
      end

      expect(brownie.ingredients).to eq(ingredients)
      brownie.mix!
      expect(brownie.ingredients).not_to eq(ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      brownie.eat(1)
      expect(brownie.quantity).to eq(49)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { brownie.eat(60) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Pillsbury the Great Baker")
      expect(brownie.serve).to eq("Chef Pillsbury the Great Baker has made 50 brownies!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(brownie)
      brownie.make_more
    end
  end
end
