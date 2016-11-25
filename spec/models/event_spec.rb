# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :string
#  max_participants :integer
#  active           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

describe Event do

  let(:event) { FactoryGirl.create :event, :with_two_date_ranges }

  it "is created by event factory" do
    expect(event).to be_valid
  end

  it "should have one or more date-ranges" do

    #checking if the event model can handle date_ranges
    expect(event.date_ranges.size).to eq 2
    expect(event.date_ranges.first.start_date).to eq(Date.tomorrow)
    expect(event.date_ranges.first.end_date).to eq(Date.tomorrow.next_day(5))
    expect(event.date_ranges.second.start_date).to eq(Date.tomorrow)
    expect(event.date_ranges.second.end_date).to eq(Date.tomorrow.next_day(10))
    expect(event.date_ranges.second).to eq(event.date_ranges.last)

    #making sure that every event has at least one date range...later...
    #event1 = FactoryGirl.create( :event, :without_date_ranges )
    #expect(event1).to_not be_valid
  end
end
