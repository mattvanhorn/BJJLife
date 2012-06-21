module ExhibitHelper

  def dollarize(cents)
    "$%.2f" % ((cents||0) / 100.0)
  end

end