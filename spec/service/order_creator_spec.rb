require 'rails_helper'

RSpec.describe OrderCreator do
  subject(:order_creator) { OrderCreator.new(user, program.id).send_order }

  let(:user) { create(:user) }
  let(:program) { create(:program, status: status, validity_period: 10) }

  context 'when the user has not bought any program and buying an ON program' do
    let(:status) { 'on' }

    it 'returns a new order' do
      expect { order_creator }.to change(Order, :count).by(1)
      allow(find_user_program(user, program.id)).to receive(:is_valid?).and_return(true)
    end
  end

  context 'when the user has not bought any program and buying an OFF program' do
    let(:status) { 'off' }

    it 'returns nothing' do
      expect { order_creator }.to change(Order, :count).by(0)
      expect(find_user_program(user, program.id)).to be_nil
    end
  end

  context 'when the user has a valid program and gonna buy it again' do
    let(:status) { 'on' }

    it 'returns nothing' do
      order_creator
      allow(find_user_program(user, program.id)).to receive(:is_valid?).and_return(true)
      expect { OrderCreator.new(user, program.id).send_order }.to change(Order, :count).by(0)
    end
  end

  context 'when the user has a invalid program and gonna buy it again' do
    let(:status) { 'on' }

    it 'returns a new order' do
      travel_to Time.zone.local(2022, 2, 12)
      order_creator
      allow(find_user_program(user, program.id)).to receive(:is_valid?).and_return(true)

      travel_to Time.zone.local(2022, 3, 23)
      allow(find_user_program(user, program.id)).to receive(:is_valid?).and_return(false)
      expect { OrderCreator.new(user, program.id).send_order }.to change(Order, :count).by(1)
      allow(find_user_program(user, program.id)).to receive(:is_valid?).and_return(true)
    end
  end

  private

  def find_user_program(user, program_id)
    user.user_programs.find{ |user_program| user_program.program_id == program_id }
  end
end