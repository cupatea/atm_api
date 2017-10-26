require 'test_helper'

class BanknoteTest < ActiveSupport::TestCase
  test 'should calculate total ' do
    Banknote.update_all quantity: 0
    assert Banknote.total.zero?
    Banknote.update_all quantity: 1
    assert_equal Banknote.kinds.values.sum, Banknote.total
  end
end
