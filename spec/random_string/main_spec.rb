require 'spec_helper'

describe "RandomString::Main" do
	include RandomString::Main

	describe '#generate' do
		let(:pattern) { /^[a-z0-9_\.]+@[a-z]+\.[a-z]+$/i }

		before { should_receive(:sample_strings).and_return(strings) }

		context 'only matches strings' do
			let(:strings) {
				[
					'nqtien310@gmail.com',
					'nqtien310@hotdev.com'
				]
			}			
			let(:expected) do
				{
					:matched_strings => strings,
					:unmatched_strings => []
				}
			end

			it 'should return matches string' do
				gen(pattern).should eq expected
			end
		end

		context 'only unmatched strings' do
			let(:strings) {
				[
					'nqtien310',
					'nqtien310'
				]
			}			
			let(:expected) do
				{
					:matched_strings => [],
					:unmatched_strings => strings
				}
			end

			it 'should return matches string' do
				gen(pattern).should eq expected
			end
		end

		context 'both matched and unmatched strings' do
			let(:strings) {
				[
					'nqtien310@gmail.com',
					'nqtien310'
				]
			}			
			let(:expected) do
				{
					:matched_strings => ['nqtien310@gmail.com'],
					:unmatched_strings => ['nqtien310']
				}
			end

			it 'should return matches string' do
				gen(pattern).should eq expected
			end
		end

		context 'multiple return results' do
			before { RandomString::Main::ResultCount = 3 }
			
			let(:strings) {
				[
					'nqtien310@gmail.com',
					'nqtien310@skype.com',
					'nqtien310@hotmail.com',
					'nqtien310@abc.com',
					'nqtien310',
					'nqtien3101',
					'nqtien3102',
					'nqtien3103'
				]
			}			
			let(:expected) do
				{
					:matched_strings => ['nqtien310@gmail.com', 'nqtien310@skype.com', 'nqtien310@hotmail.com'],
					:unmatched_strings => ['nqtien310', 'nqtien3101', 'nqtien3102'],
				}
			end

			it 'should return maximum (specific in ResultCount) results for each type' do
				gen(pattern).should eq expected
			end
		end
	end
end