module ExhibitHelper

  def dollarize(cents)
    "$%.2f" % (cents / 100.0)
  end

end