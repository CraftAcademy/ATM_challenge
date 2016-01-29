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
      when negative_value?(amount) \
        then return_error_message(:negative_amount)
      when incorrect_pin?(pin, account.pin) \
        then return_error_message(:wrong_pin)
      when check_expiry(expiry, account.exp_date) \
        then return_error_message(:card_expired)
      when no_sufficient_fund_in_atm?(amount) \
        then return_error_message :no_sufficient_fund
      when adequate_balance_in_account?(amount, account.balance) \
        then return_error_message :no_sufficient_balance
      when amount % 5 != 0 then return_error_message :non_rounded_amount

      else
        do_transaction(amount, account)
        respons = { status: true,
          message: :success,
          date: Date.today.strftime("%F"),
          amount: amount,
          bills: do_bill_count(amount)}
     end
   end

 def do_bill_count(amount)
     amount / 5
 end

 def do_transaction(amount, _account)
   @funds -= amount
 end



  private
 def check_expiry(date, actual_exp_date)
    date != actual_exp_date
 end

 def negative_value?(value)
   value <= 0
 end

 def incorrect_pin?(pin, actual_pin)
   pin != actual_pin
 end

 def no_sufficient_fund_in_atm?(amount)
   @funds < amount
 end

 def return_error_message(message)
   { status: false, message: message, date: Date.today.strftime("%F") }
 end

 def adequate_balance_in_account?(amount, balance)
   balance < amount
 end
end
