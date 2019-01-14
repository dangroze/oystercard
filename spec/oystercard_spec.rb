require 'oystercard'
RSpec.describe Oystercard do
  it {is_expected.to respond_to(:balance)}
  it {is_expected.to respond_to(:top_up)}
end
