require 'spec_helper'

describe "RandomString::SampleString" do
	include RandomString::SampleString

	describe "#stored_data"	do
		it 'should return an array of string' do
			send(:stored_data).should be_an Array
			send(:stored_data).should_not be_empty
		end
	end

	describe '#random_digits' do
		let(:random_digits) { send(:random_digits_data) }

		it 'should return array with maximum size config in SampleString::GenerateCount' do
			random_digits.size.should eq RandomString::SampleString::GenerateCount
		end

		it 'should return array of different length digits' do			
			random_digits.each { |random_str|	(random_str =~ /^[0-9]+$/).should_not be_nil }
		end
	end

	describe '#random_chars' do
		let(:random_chars) { send(:random_chars_data) }
		
		it 'should return array with maximum size config in SampleString::GenerateCount' do
			random_chars.size.should eq RandomString::SampleString::GenerateCount
		end

		it 'should return array of different length digits' do
			random_chars.each { |random_str|	(random_str =~ /^[a-zA-Z]+$/).should_not be_nil }
		end
	end

	describe '#percentage_data' do
		it 'should contain percentage numbers' do
			pd = send(:percentages_data)
			pd.size.should == 100
			pd.should be_include("50%")
		end
	end

	describe '#floats_data' do
		it 'should contain float numbers from 0 to 1 step 0.01' do
			pd = send(:floats_data)
			pd.size.should == 100			
			pd.should be_include("0.99")
		end
	end


	describe '#sample_strings' do
		before do
			should_receive(:random_chars_data).once.and_return [1,2,3]
			should_receive(:random_digits_data).once.and_return [4,5,6,6]
			should_receive(:stored_data).once.and_return [7,8,9]
			should_receive(:percentages_data).once.and_return(10)
			should_receive(:floats_data).once
		end

		it 'should return an unique array which is a combination of stored_data, random_digits, random_chars' do			
			send(:sample_strings).sort.should eq [1,2,3,4,5,6,7,8,9,10]
		end

		it 'should shuffle the result' do
			send(:sample_strings).should_not eq [1,2,3,4,5,6,7,8,9,10]
		end
	end

end