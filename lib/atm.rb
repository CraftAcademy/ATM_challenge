require 'date'

class Atm
  attr_accessor :funds
  STANDARD_PIN = 1234
  STANDARD_EXP_DATE = "10/17".freeze

  def initialize
    @funds = 1000
  end

  def withdraw(amount, pin, expiry, account)
    case
    when negative_value?(amount) then return_error_message(:negative_amount)
    when !correct_pin?(pin, account.pin) then return_error_message(:wrong_pin)
    when card_expired?(expiry, account.exp_date) then return_error_message(:card_expired)
    when !suffient_funds_in_account?(amount, account) then return_error_message(:account_balance_too_low)
    when !sufficient_fund_in_atm?(amount) then return_error_message :no_sufficient_fund
    when amount % 5 != 0 then return_error_message :non_rounded_amount
    else
      do_transaction(amount, account)
      respons = { status: true,
                  message: :success,
                  date: Date.today.strftime("%F"),
                  amount: amount,
                  bills: do_bill_count(amount) }
     end
   end

 def do_bill_count(amount)
     amount / 5
 end

 def do_transaction(amount, account)
   @funds -= amount
   account.balance = account.balance - amount
 end


  private
  
  def card_expired?(date, actual_exp_date)
    date != actual_exp_date
  end

  def negative_value?(value)
   value <= 0
  end

  def correct_pin?(pin, actual_pin)
   pin == actual_pin
  end

  def sufficient_fund_in_atm?(amount)
   @funds > amount
  end

  def suffient_funds_in_account?(amount, account)
   account.balance > amount
  end

  def return_error_message(message)
   { status: false, message: message, date: Date.today.strftime("%F") }
  end

end
