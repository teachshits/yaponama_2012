class PostalAddress < ActiveRecord::Base
  has_paper_trail
  include BelongsToUser
  has_many :orders

  validates :city, :street, :house, :region, :postcode, :presence => true

  def to_label
    "#{company} - #{postcode} - #{region} - #{city} - #{street} - #{house} - #{room} - #{notes} - #{notes_invisible}"
  end
end
