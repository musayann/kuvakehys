require 'rails_helper'

RSpec.describe Photo, type: :model do

  describe 'analyze size' do
    subject { FactoryGirl.create(:photo, width: nil, height: nil) }
    it 'sets width and heigth' do
      expect(subject.width).to eql(640)
      expect(subject.height).to eql(640)
    end
  end

  describe 'print_type' do
    context '10x15' do
      subject { FactoryGirl.build(:photo, width: 601, height: 901) }
      it { expect(subject.print_type).to eql('10x15_cm') }
    end
    context '9x13' do
      subject { FactoryGirl.build(:photo, width: 599, height: 901) }
      it { expect(subject.print_type).to eql('9x13_cm') }
    end

  end

  describe "create order" do
    context 'full' do
      let(:group) { FactoryGirl.create(:group, photo_limit: 2) }
      before do
        FactoryGirl.create(:photo, group: group)
        allow_any_instance_of(Order).to receive(:complete!).and_return(true)
      end

      it 'creates a new order' do
        FactoryGirl.create(:photo, group: group)
        expect(group.orders.count).to eql(1)
      end
    end

    context 'not full' do
      let(:group) { FactoryGirl.create(:group, photo_limit: 2) }
      it 'creates a new order' do
        FactoryGirl.create(:photo, group: group)
        expect(group.orders.count).to eql(0)
      end
    end
  end

end
