require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test 'should calculate amount after refill' do
    transaction = Transaction.create kind: 'refill', banknotes: { 1 => 5, 2 => 10 }
    assert_equal 25, transaction.amount
  end
end
