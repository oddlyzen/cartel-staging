require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe '#user_profile_path' do
    context 'when user is artist' do
      let(:user) { build_stubbed(:user, :artist) }
      it { expect(user_profile_path(user)).to eq artist_path(user.id) }
    end

    context 'when user is professional' do
      let(:user) { build_stubbed(:user, :professional) }
      it { expect(user_profile_path(user)).to eq professional_path(user.id) }
    end
  end

  describe '#bootstrap_class_for' do
    context 'flash type success' do
      it { expect(bootstrap_class_for('success')).to eq('alert-success') }
    end

    context 'flash type notice' do
      it { expect(bootstrap_class_for('notice')).to eq('alert-success') }
    end

    context 'flash type error' do
      it { expect(bootstrap_class_for('error')).to eq('alert-danger') }
    end

    context 'flash type alert' do
      it { expect(bootstrap_class_for('alert')).to eq('alert-danger') }
    end

    context 'flash type info' do
      it { expect(bootstrap_class_for('info')).to eq('alert-info') }
    end

    context 'flash type other' do
      it { expect(bootstrap_class_for('other')).to eq('alert-warning') }
    end
  end

  describe '#flash_icon_for' do
    context 'flash type success' do
      it { expect(flash_icon_for('success')).to eq('check') }
    end

    context 'flash type notice' do
      it { expect(flash_icon_for('notice')).to eq('check') }
    end

    context 'flash type error' do
      it { expect(flash_icon_for('error')).to eq('ban') }
    end

    context 'flash type alert' do
      it { expect(flash_icon_for('alert')).to eq('ban') }
    end

    context 'flash type info' do
      it { expect(flash_icon_for('info')).to eq('info') }
    end

    context 'flash type other' do
      it { expect(flash_icon_for('other')).to eq('warning') }
    end
  end

  describe '#options_for_enum' do
    let(:enum_key1) { 'some_key' }
    let(:enum_key2) { 'some_other_key' }
    let(:enum_hash) { { enum_key1 => 1, enum_key2 => 2 } }

    let(:expected_result) do
      [
        [enum_key1.humanize, enum_key1],
        [enum_key2.humanize, enum_key2]
      ]
    end

    it { expect(options_for_enum(enum_hash)).to contain_exactly(*expected_result) }
  end

  describe '#options_for_array' do
    let(:array_key1) { 'some_key' }
    let(:array_key2) { 'some_other_key' }
    let(:array_input) do
      [
        [array_key1, 1],
        [array_key2, 2]
      ]
    end

    let(:expected_result) do
      [
        [array_key1.humanize, array_key1],
        [array_key2.humanize, array_key2]
      ]
    end

    it { expect(options_for_array(array_input)).to contain_exactly(*expected_result) }
  end

  describe '#external_link' do
    let(:obj_struct) { Struct.new(:title, :link) }
    let(:obj_title) { 'Some Title' }
    let(:obj_link) { 'Some-Link' }
    let(:obj) { obj_struct.new(obj_title, obj_link) }

    context 'when object has link' do
      context 'when object has title' do
        it { expect(external_link(obj)).to eq("<a href=\"http://#{obj_link}\">#{obj_title}</a>") }
      end

      context 'when object has no title' do
        let(:obj_title) { nil }
        it { expect(external_link(obj)).to eq("<a href=\"http://#{obj_link}\">Untitled</a>") }
      end
    end

    context 'when object does not have link' do
      let(:obj_link) { nil }
      it { expect(external_link(obj)).to eq(obj_title) }
    end
  end

  describe '#active_if' do
    let(:path1) { 'path1' }
    let(:path2) { 'path2' }
    let(:paths_params) { [path1, path2] }

    before do
      allow(self).to receive(:current_page?).with(path1).and_return(false)
      allow(self).to receive(:current_page?).with(path2).and_return(true)
    end

    context 'current page is in params' do
      it 'returns active' do
        expect(active_if(paths_params)).to eq('active')
      end
    end

    context 'current page is not in params' do
      let(:paths_params) { [path1] }
      it 'returns empty string' do
        expect(active_if(paths_params)).to eq('')
      end
    end
  end

  describe '#email_to_gravatar' do
    let(:email) { 'someemail@example.com' }
    let(:digested_email) { Digest::MD5.hexdigest(email.downcase) }

    it do
      expect(email_to_gravatar(email)).to eq(
        "https://gravatar.com/avatar/#{digested_email}.png?s=96&d=mm"
      )
    end
  end

end
