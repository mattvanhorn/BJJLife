class Academy < ActiveRecord::Base
  attr_accessible :name, :street, :unit, :city, :us_state, :postal_code, :email, :phone_number, :website

  validates_with LocationValidator
  validates_with ContactMethodValidator
  validates_presence_of :name
  validates :email, :length => (3..254),
                    :email => true,
                    :allow_blank => true
  validates :us_state, :length => {:is => 2},
                       :allow_blank => true

end