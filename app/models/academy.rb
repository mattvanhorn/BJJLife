class Academy < ActiveRecord::Base
  validates_with LocationValidator
  validates_with ContactMethodValidator
  validates_presence_of :name
  validates :email, :length => (3..254),
                    :email => true,
                    :allow_blank => true
  validates :us_state, :length => {:is => 2},
                       :allow_blank => true

end