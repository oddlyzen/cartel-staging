require 'rails_helper'

RSpec.describe BibliographyDecorator, type: :decorator do
  let(:bibliography) { build(:bibliography) }

  subject(:decorator) { described_class.new(bibliography) }

  describe '#full_title' do
    context 'when attachment_url present' do
      let(:bibliography) { build(:bibliography, :with_attachment) }

      it { expect(decorator.full_title).to have_tag(:a, text: bibliography.title, href: bibliography.attachment_url) }
    end

    context 'when pdf_url present' do
      let(:bibliography) { build(:bibliography, :with_pdf) }

      it { expect(decorator.full_title).to have_tag(:a, text: bibliography.pdf_url.split('/').last, href: bibliography.pdf_url) }
    end

    context 'when attachment_url and pdf_url are blank' do
      it { expect(decorator.full_title).to eq bibliography.title }
    end
  end

end
