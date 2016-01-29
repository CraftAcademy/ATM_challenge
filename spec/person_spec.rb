require './lib/person.rb'

describe Person do
  subject { described_class.new('Random') }
  let(:account) { double(:account, holder: subject, balance: 100, pin: 1234, exp_date: '10/17') }
  let(:atm) { double(:atm) }

  before do
    subject.accounts.push account
    allow(atm).to receive(:withdraw)
  end

  it 'should have access to account information' do
    expect(subject.accounts[0]).to equal account
  end

  it 'deduct money when atm withdraw from balance' do
    subject.get_cash(40, account, atm, account.pin)
    expect(subject.cash).to eq 40
  end
end
