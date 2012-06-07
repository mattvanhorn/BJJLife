class Array
  def deblankify
    collect(&:presence).compact
  end

  def clean_join(*args)
    join(*args).strip
  end
end