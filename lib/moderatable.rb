require 'state_machine'

module Moderatable
  def self.included(base)
    base.class_exec do
      scope :pending,   where(:state => 'pending')
      scope :published, where(:state => 'published')

      state_machine :initial => :pending do
        state :pending
        state :published

        event :publish do
          transition :pending => :published
        end
      end
    end
  end
end

