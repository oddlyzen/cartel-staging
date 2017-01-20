require 'rails_helper'

RSpec.describe ServiceCall do
  let(:result) { Struct.new(:foo, :bar) }

  subject(:service_call) { ServiceCall.new(result) }

  describe 'success?' do
    context 'without errors' do
      it { expect(service_call).to be_success }
    end

    context 'with errors' do
      before { service_call.errors << 'foo' }

      it { expect(service_call).not_to be_success }
    end
  end

  describe 'data' do
    context 'with configured values' do
      it { expect(service_call.data).to respond_to(:foo) }
      it { expect(service_call.data).to respond_to(:bar) }
    end
  end
end
