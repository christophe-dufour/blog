require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to be_embedded_in(:post).as_inverse_of(:comments) }

  it 'is valid with a body, a post' do
    comment = build(:comment)
    expect(comment).to be_valid
  end
  it 'is invalid without a body' do
    comment = build(:comment, body: nil)
    expect(comment).to_not be_valid
    expect(comment.errors[:body]).to include("can't be blank")
  end
  it 'is invalid without a post' do
    comment = build(:comment, post: nil)
    expect(comment).to_not be_valid
    expect(comment.errors[:post]).to include("can't be blank")
  end
end
