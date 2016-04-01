### ATM Challenge

This is the week 1 challenge of the Craft Academy Bootcamp. The challenge is to simulate an ATM-machine. Ruby will be the main programing language to use

### Usage

Open up `irb` and run the following commands:

```irb
2.2.1 :002 > load './lib/atm.rb'
 => true
2.2.1 :003 > load './lib/person.rb'
 => true
2.2.1 :004 > load './lib/account.rb'
 => true
 ```
```irb
# Create person
2.2.1 :005 > person = Person.new('Thomas')
 => #<Person:0x007ff4f912ed28 @name="Thomas", @cash=0>
# Create account
2.2.1 :006 > account = person.create_account(Account)
=> #<Account:0x007ff4f8b5e290 @holder=#<Person:0x007ff4f912ed28 @name="Thomas", @cash=0, @accounts=[#<Account:0x007ff4f8b5e290 ...>]>, @balance=0, @exp_date="10/17", @pin=3513>
# Create an ATM
2.2.1 :007 > atm = Atm.new
=> #<Atm:0x007ff4f90fcbe8 @funds=1000>
```

```irb
# Deposit funds to account
2.2.1 :008 > account.deposit 100
```

```irb
# Withdraw funds from account
person.get_cash(50, account, atm, 3513) # Make sure to use your own PIN ;-)
 => 50
2.2.1 :015 > person.cash
 => 50
2.2.1 :016 > account.balance
=> 50
 2.2.1 :017 > atm.funds
=> 950
```
