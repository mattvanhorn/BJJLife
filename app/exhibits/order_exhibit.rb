class OrderExhibit< DisplayCase::Exhibit

  def self.applicable_to?(object)
    object.class.name == 'Order'
  end

  def item
    exhibit(__getobj__.item)
  end

  def amount
    "$%.2f" % (__getobj__.amount / 100.0)
  end

end
