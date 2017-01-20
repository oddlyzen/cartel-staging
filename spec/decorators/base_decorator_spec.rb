require 'rails_helper'

RSpec.describe BaseDecorator, type: :decorator do

  let(:undecorated_instance) { instance_double('some_activerecord_record') }

  subject { described_class.new(undecorated_instance) }

  it { is_expected.to be_a_decorated(undecorated_instance).with(described_class) }

  describe '#wrap_all' do
    let(:undecorated_instances) { Array.new(3, undecorated_instance) }

    it { expect(BaseDecorator.wrap_all(undecorated_instances)).to contain_decorated(*undecorated_instances).with(described_class) }

  end

  describe '#==' do
    it { expect(subject).to eq(described_class.new(undecorated_instance)) }
  end

end
