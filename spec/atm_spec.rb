require './lib/atm.rb'

describe Atm do

  let(:person) { double(:person) }
  let(:account) { double(:account, holder: person, pin: 1234, exp_date: '10/17', balance: 100) }

  before do
    allow(account).to receive(:balance=)
  end

  context 'has sufficient funds' do
    before do
      subject.funds = 1000
    end

    it 'allows for withdraw of 5$ if pin is okay' do
      output = { status: true,
                 message: :success,
                 date: Date.today.strftime('%F'),
                 amount: 5,
                 bills: 1
        }

      expect(subject.withdraw(5, account.pin, account.exp_date, account)).to eq output
    end

    it 'does not allow for withdraw of 5$ if pin is wrong' do
      output = { status: false,
                 message: :wrong_pin,
                 date: Date.today.strftime('%F')
        }
      expect(subject.withdraw(5, 9999, account.exp_date, account)).to eq output
    end

    it 'does not allow for withdraw of 6$ even if pin is okay' do
      output = { status: false,
                 message: :non_rounded_amount,
                 date: Date.today.strftime('%F')
        }
      expect(subject.withdraw(6, account.pin, account.exp_date, account)).to eq output
    end

    it 'does not allow for withdraw if card is expired' do
      output = { status: false,
                 message: :card_expired,
                 date: Date.today.strftime('%F')
        }
      expect(subject.withdraw(6, account.pin, '02/09', account)).to eq output
    end

    it 'does not allow for withdraw of -10$ even if pin is okay' do
      output = { status: false,
                 message: :negative_amount,
                 date: Date.today.strftime('%F')
        }
      expect(subject.withdraw(-10, account.pin, account.exp_date, account)).to eq output
    end

    it 'subtract withdrawal amount from avilable funds' do
      subject.do_transaction(5, account)
      expect(subject.funds).to eq 995
    end

    it 'does not allow for withdraw of 100$ from ATM if money not avilable in person account' do
      output = { status: false,
                 message: :no_sufficient_balance,
                 date: Date.today.strftime('%F')
        }
      expect(subject.withdraw(100, account.pin, account.exp_date, account)).to eq output
    end
  end

  context 'is out of funds' do
    before do
      subject.funds = 0
    end

    it 'rejects withdraw of 5$ if pin is okay' do
      output = { status: false,
                 message: :no_sufficient_fund,
                 date: Date.today.strftime('%F')
        }
      expect(subject.withdraw(5, account.pin, account.exp_date, account)).to eq output
    end
  end

  context "don't have enough funds" do
    before do
      subject.funds = 25
    end

    it 'rejects withdraw of 30$ if funds are 25$' do
      output = { status: false,
                 message: :no_sufficient_fund,
                 date: Date.today.strftime('%F')
        }
      expect(subject.withdraw(30, account.pin, account.exp_date, account)).to eq output
    end
  end
end
