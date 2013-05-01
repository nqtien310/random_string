require 'random_string/sample_string'

module RandomString
	module Main	
		include RandomString::SampleString
		
		def generate(pattern)
			matched_strings = []
			unmatched_strings = []			
			sample_strings.each do |sample_string|
				break if matched_strings.size == ResultCount && unmatched_strings.size == ResultCount

				if sample_string =~ pattern
					matched_strings << sample_string if matched_strings.size < ResultCount
				else
					unmatched_strings << sample_string if unmatched_strings.size < ResultCount
				end
			end

			{
				matched_strings:   matched_strings,
				unmatched_strings: unmatched_strings
			}
		end

		alias_method :gen, :generate		
	end
end