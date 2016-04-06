class Account
  attr_accessor :holder, :balance, :exp_date, :pin

  def initialize(options={})
    @holder = options[:holder]
    if options[:holder].respond_to?(:accounts)
       options[:holder].accounts.push self
    end
    @balance = options[:balance] || 0
    @exp_date = set_exp_date
    @pin = generate_pin
  end

  def deposit(amount) 
    @balance += amount
  end

  def atm_withdraw(amount)
    @balance -= amount
  end

  private

  def set_exp_date
    # TODO: Set the exp date 5 yrs from Date.today
    "10/17"
  end

  def generate_pin
    rand(1000..9999)
  end
end
