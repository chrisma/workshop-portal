# == Schema Information
#
# Table name: workshops
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :string
#  max_participants :integer
#  active           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :workshop do
    name "Workshop-Name"
    description "Workshop-Description"
    max_participants 1
    active false
    DateRanges {build_list :dateRange, 1}
  end
end
