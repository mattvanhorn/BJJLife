Fabricator(:product) do
  name 'Private Lesson'
  price 20000
  photo 'sloth.jpg'
end


Fabricator(:product_with_category_and_market, from: :product) do
  market
  category
end
