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
				Data::StoredStrings.values.flatten
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

			def floats_data
				(0...1).step(0.01).to_a.map.each {|f| f.round(2).to_s}
			end

			def random_strings(base)
				(1..GenerateCount).map { |length| length.times.inject('') { |initial, n| initial + base[rand(base.size-1)].to_s } }
			end			
	end
end