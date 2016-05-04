# == Schema Information
#
# Table name: benches
#
#  id          :integer          not null, primary key
#  description :string
#  lat         :float            not null
#  lng         :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Bench < ActiveRecord::Base
  validates :lat, :lng, :description, :seating, presence: true

  def self.in_bounds(bounds)
    Bench.where(lat: bounds[:westBound]..bounds[:eastBound],
                lng: bounds[:southBound]..bounds[:northBound])
  end
end
