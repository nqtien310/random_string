require 'spec_helper'

describe "RandomString::SampleString" do
	include RandomString::SampleString

	describe "#stored_strings"	do
		it 'should return an array of string' do
			send(:stored_strings).should be_an Array
			send(:stored_strings).should_not be_empty
		end
	end

	describe '#random_digits' do
		let(:random_digits) { send(:random_digits_strings) }

		it 'should return array with maximum size config in SampleString::GenerateCount' do
			random_digits.size.should eq RandomString::SampleString::GenerateCount
		end

		it 'should return array of different length digits' do			
			random_digits.each { |random_str|	(random_str =~ /^[0-9]+$/).should_not be_nil }
		end
	end

	describe '#random_chars' do
		let(:random_chars) { send(:random_chars_strings) }
		
		it 'should return array with maximum size config in SampleString::GenerateCount' do
			random_chars.size.should eq RandomString::SampleString::GenerateCount
		end

		it 'should return array of different length digits' do
			random_chars.each { |random_str|	(random_str =~ /^[a-zA-Z]+$/).should_not be_nil }
		end
	end

	describe '#sample_strings' do
		before do
			should_receive(:random_chars_strings).once.and_return [1,2,3]
			should_receive(:random_digits_strings).once.and_return [4,5,6,6]
			should_receive(:stored_strings).once.and_return [7,8,9]
		end

		it 'should return an unique array which is a combination of stored_strings, random_digits, random_chars' do			
			send(:sample_strings).sort.should eq [1,2,3,4,5,6,7,8,9]
		end

		it 'should shuffle the result' do
			send(:sample_strings).should_not eq [1,2,3,4,5,6,7,8,9]
		end
	end
end