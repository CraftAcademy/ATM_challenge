require './lib/account'

class Person
  attr_accessor :name, :cash, :accounts

  def initialize(name)
    @name = name
    @cash = 0
    @accounts = []
  end

  def create_account(account_class)
    account_class.new(holder: self)
    end

  def get_cash(amount, account, atm, pin)
    atm.withdraw(amount, pin, account.exp_date, account)
    @cash += amount
  end
end
