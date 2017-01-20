require 'rails_helper'

RSpec.describe ArtworkCollaborator, type: :model do
  it { should belong_to(:collaborator) }
  it { should belong_to(:artwork) }

  it { should validate_presence_of(:artwork) }
  it { should validate_presence_of(:collaborator) }
end
