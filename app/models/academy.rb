class Academy < ActiveRecord::Base
  attr_accessible :name, :instructor, :street, :unit, :city, :us_state, :postal_code, :email, :phone_number, :website

  validates_with LocationValidator
  validates_with ContactMethodValidator
  validates_presence_of :name
  validates :email, :length => (3..254),
                    :email => true,
                    :allow_blank => true
  validates :us_state, :length => {:is => 2},
                       :allow_blank => true

  state_machine :initial => :pending do
    state :pending
    state :published

    event :publish do
      transition :pending => :published
    end
  end

  def self.published
    with_state('published')
  end

  def self.pending
    with_state('pending')
  end

end