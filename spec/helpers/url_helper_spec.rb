require 'rails_helper'

RSpec.describe UrlHelper, type: :helper do

  describe '#external_url' do
    context 'with scheme' do
      let(:url) { 'http://www.pan.com' }

      it { expect(external_url(url)).to eq 'http://www.pan.com' }
    end

    context 'without scheme' do
      let(:url) { 'www.pan.com' }

      it { expect(external_url(url)).to eq 'http://www.pan.com' }
    end
  end

end
