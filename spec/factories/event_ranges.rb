# == Schema Information
#
# Table name: dateRange
#
# id					:integer
# startDate				:date
# endDate 				:date
#


FactoryGirl.define do
	factory :dateRange  do
		startDate Date.new(2016, 1, 1)
		endDate Date.new(2016, 2, 2)
	end 
end



