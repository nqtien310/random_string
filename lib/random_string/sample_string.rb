require "random_string/sample_string/data"

module RandomString
	module SampleString
		ResultCount    = 3
		GenerateCount  = 50
		LowerCaseChars = ('a'..'z').to_a
		UpperCaseChars = ('A'..'Z').to_a
		Digits 				 = (0..9).to_a
		
		private 

			def sample_strings
				private_methods.select { |method| method =~ /_data$/ }.inject([]) do |all, method|					
					all << eval(method.to_s) 
				end.flatten.compact.uniq.shuffle				
			end

			def stored_data
				( stored_strings + capitalize_stored_strings + dot_prefix_stored_strings ).flatten.uniq				
			end

			def random_digits_data
				random_strings(Digits)
			end

			def random_chars_data
				random_strings(LowerCaseChars + UpperCaseChars)
			end

			def percentages_data
				(1..100).map { |n| "#{n}%"}
			end

			def digits_data
				Digits
			end

			def lower_case_chars_data
				LowerCaseChars
			end

			def upper_case_chars_data
				UpperCaseChars
			end

			def floats_data
				(0...1).step(0.01).to_a.map.each {|f| f.round(2).to_s}
			end

			def stored_strings
				Data::StoredStrings.values.flatten
			end

			def capitalize_stored_strings
				( Data::CapitalStoredStrings.values + Data::CapitalStoredStrings.values.flatten.map(&:capitalize) ).flatten
			end

			def dot_prefix_stored_strings
				( Data::DotPrefixStoredStrings.values + Data::DotPrefixStoredStrings.values.flatten.map { |v| ".#{v}"} ).flatten
			end

			def random_strings(base)
				(1..GenerateCount).map { |length| length.times.inject('') { |initial, n| initial + base[rand(base.size-1)].to_s } }
			end			
	end
end