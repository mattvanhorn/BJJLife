class Academy < ActiveRecord::Base
  attr_accessible :name, :instructor, :street, :unit, :city, :us_state, :postal_code, :email, :phone_number, :website

  validates_with LocationValidator
  validates_with ContactMethodValidator
  validates_presence_of :name
  validates :email, :length => (3..254), :email => true, :allow_blank => true
  validates :us_state, :length => {:is => 2}, :allow_blank => true

  scope :pending,   where(:state => 'pending')
  scope :published, where(:state => 'published')
  scope :ordered_by_state, published.order('us_state, name')

  state_machine :initial => :pending do
    state :pending
    state :published

    event :publish do
      transition :pending => :published
    end
  end

  def self.by_state
    Academy.ordered_by_state.group_by(&:us_state).to_a.each do |state_group|
      state_group.define_singleton_method :to_partial_path, lambda{'state'}
    end
  end
end