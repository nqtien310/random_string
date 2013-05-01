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
				(stored_strings + random_digits_strings + random_chars_strings).uniq.shuffle
			end

			def stored_strings
				Data::StoredStrings.values.flatten
			end

			def random_digits_strings
				random_strings(Digits)
			end

			def random_chars_strings
				random_strings(LowerCaseChars + UpperCaseChars)
			end

			def random_strings(base)
				(1..GenerateCount).map { |length| length.times.inject('') { |initial, n| initial + base[rand(base.size-1)].to_s } }
			end				
	end
end