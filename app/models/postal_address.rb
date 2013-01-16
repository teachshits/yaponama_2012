class PostalAddress < ActiveRecord::Base
  include BelongsToCreator
  include PingCallback
  has_many :orders

  belongs_to :user#, :validate => true
  validates :user, :presence => true

  #validates :user, :presence => true

  validates :city, :street, :house, :region, :postcode, :presence => true

  def to_label
    "#{company} - #{postcode} - #{region} - #{city} - #{street} - #{house} - #{room} - #{notes} - #{notes_invisible}"
  end
end
