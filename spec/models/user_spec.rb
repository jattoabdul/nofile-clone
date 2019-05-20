require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Association' do
    it { should have_many(:uploads) }
  end

  xcontext 'Validation' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:guest) }
  end
end
