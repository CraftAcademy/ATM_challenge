class Account
  attr_accessor :holder, :balance
  attr_reader :pin, :exp_date
  STANDARD_VALIDITY_YRS = 5

  def initialize(options={})
    @holder = options[:holder]
    if options[:holder].respond_to?(:accounts)
      options[:holder].accounts.push self
    end
    @balance = options[:balance] || 0
    @exp_date = set_exp_date
    @pin = generate_pin
  end

  def deposit(amount) #TODO shouldnt include @account ?
    @balance += amount
  end

  def atm_withdraw(amount)
    @balance -= amount
  end

  private

  def set_exp_date
    Date.today.next_year(STANDARD_VALIDITY_YRS).strftime("%m/%y")
  end

  def generate_pin
    rand(1000..9999)
  end
end
