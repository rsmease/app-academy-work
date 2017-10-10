require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "Jack Sparrow") }
  let(:cheesecake) { Dessert.new("cheesecake", 400, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(cheesecake.type).to eq("cheesecake")
    end

    it "sets a quantity" do
      expect(cheesecake.quantity).to eq(400)
    end

    it "starts ingredients as an empty array" do
      expect(cheesecake.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("cheesecake", "400", "Jack Sparrow") }.to raise_error ArgumentError
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      cheesecake.add_ingredient("lemon")
      expect(cheesecake.ingredients).to include("lemon")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["milk", "cream", "sugar", "cheese"]
      ingredients.each do |ingredient|
        cheesecake.add_ingredient(ingredient)
      end
      expect(cheesecake.ingredients).to eq(ingredients)
      cheesecake.mix!
      expect(cheesecake.ingredients).not_to eq(ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      cheesecake.eat(40)
      expect(cheesecake.quantity).to eq(360)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { cheesecake.eat(500).to raise_error("not enough left!")}
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Jack Sparrow")
      expect(cheesecake.serve).to eq("Jack Sparrow has made 400 cheesecakes!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
       expect(chef).to receive(:bake).with(cheesecake)
       cheesecake.make_more
     end
  end
end
