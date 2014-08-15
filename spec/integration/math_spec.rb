require 'spec_helper'

describe 'Mathmatical Operations' do
  context 'literal values' do
    it 'displays the last evaluated integer' do
      expect("1").to be_exp "1"
      expect("10").to be_exp "10"
    end

    it 'displays the last evaluated float' do
      expect("1.1").to be_exp "1.1"
      expect("123.11").to be_exp "123.11"
    end
  end

  describe "arithmetic operators" do
    it "can add numbers" do
      expect("1+1").to be_exp "2"
      expect("2+10+0").to be_exp "12"
      expect("0+2").to be_exp "2"
    end

    it "can subtract numbers" do
      expect("1-1").to be_exp "0"
      expect("10-2-4").to be_exp "4"
      expect("2-0").to be_exp "2"
    end

    it "can multiply numbers" do
      expect("1*1").to be_exp "1"
      expect("100*0").to be_exp "0"
      expect("10*2*4").to be_exp "80"
      expect("3*3*3").to be_exp "27"
    end

    it "can divide numbers" do
      expect("1/1").to be_exp "1"
      expect("100/10").to be_exp "10"
      expect("10/2").to be_exp "5"
      expect("3/20.0").to be_exp "0.15"
    end

    context "handles order of operations" do
      it "with multiple operators" do
        expect("1+1*2").to be_exp "3"
        expect("10*10/5-1").to be_exp "19"
        expect("(10*5)/(5.0-1)").to be_exp "12.5"
      end
    end
  end
end
