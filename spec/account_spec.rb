require './lib/account.rb'

describe Account do
  let(:person) { double(:person, accounts: []) }
  let(:subject_2) { described_class.new(holder: person, balance: 100) }

  it 'expect new account holder name to be The guy' do
    expect(subject_2.holder).to eq person
  end

  it 'expect new account exp_date to be +5 years' do
    date_5_yrs = Date.today.next_year(5).strftime("%m/%y")
    expect(subject_2.exp_date).to eq date_5_yrs
  end

  it 'expect new account pin to be 4 digits' do
    pin_digits = Math.log10(subject_2.pin).to_i + 1
    expect(pin_digits).to eq 4
  end

  it 'expect new account initial balance to be 100' do
    expect(subject_2.balance).to eq 100
  end

  it 'expect to allow a deposit to be made' do
    subject.deposit(500)
    expect(subject.balance).to eq 500
  end

  it 'expect to deduct money when atm withdraw from balance' do
    subject.atm_withdraw(40)
    expect(subject.balance).to eq -40
  end
end
