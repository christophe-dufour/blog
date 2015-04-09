require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to be_embedded_in(:post).as_inverse_of(:comment) }
end
