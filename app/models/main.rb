require_relative 'senator'
require_relative 'representative'

def query_legislators_by_states(state_of_interest)
	puts "Senators:"
	sen_arr = Senator.order(lastname: :asc).where(state:state_of_interest)
	sen_arr.each { |sen| puts "  #{sen.firstname} #{sen.lastname} #{sen.name_suffix} (#{sen.party})"}

	puts "Representatives:"
	rep_arr = Representative.order(lastname: :asc).where(state:state_of_interest)
	rep_arr.each { |rep| puts "  #{rep.firstname} #{rep.lastname} #{rep.name_suffix} (#{rep.party})"}
end

query_legislators_by_states("CA")


def query_by_gender(gender_of_interest)
	sen_count = Senator.where(gender:gender_of_interest).count
	total_sen_count = Senator.count 
	
	rep_count = Representative.where(gender:gender_of_interest).count
	total_rep_count = Representative.count 

	puts "#{gender_of_interest} Senators: #{sen_count} (#{100*sen_count/total_sen_count}%)"
	puts "#{gender_of_interest} Representatives: #{rep_count} (#{100*rep_count/total_rep_count}%)"
end

query_by_gender("M")
query_by_gender("F")


#Print out the list of states along with how many active senators and representatives are in each, in descending order (i.e., print out states with the most congresspeople first).


def query_num_of_legislators_by_states
	hash1 = Representative.group(:state).count
	arr = hash1.to_a
	hash2 = Senator.group(:state).count 
	arr.sort_by! { |arr_within_arr| arr_within_arr[1] + hash2[arr_within_arr[0]] } # looks at the num of sen & rep to sort
	arr.reverse!
	arr.each do |a| 
		state = a[0]
		puts "#{state}: #{hash2[state]} Senators, #{a[1]} Representative(s)"
	end
end

query_num_of_legislators_by_states

def count_sen_rep
	puts "Senators: #{Senator.count}"
	puts "Representatives: #{Representative.count}"
end

count_sen_rep

Legislator.where(in_office:"0").destroy_all

count_sen_rep

## p Legislator.select(:state).distinct.class == Legislator::ActiveRecord_Relation


