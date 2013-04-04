require 'spec_helper'

describe Address do
  let(:address) { Address.new('350 5th Avenue', '600th Floor', 'New York', 'NY', '10001') }

  # Nova União (Academia Upper)
  # Rua Marques de Abrante, 88
  # Flamengo - Rio de Janeiro, RJ
  # 22230-061
  # Brazil

  subject { address }

  it "works" do
    true
  end
end

