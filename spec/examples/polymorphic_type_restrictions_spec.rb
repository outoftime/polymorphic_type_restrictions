require File.join(File.dirname(__FILE__), 'spec_helper')

describe PolymorphicTypeRestrictions do
  before :each do
    @comment = Comment.new
  end

  it 'should allow commentables to be set directly' do
    lambda { @comment.commentable = Post.new }.should_not raise_error
  end

  it 'should not allow non-commentables to be set directly' do
    lambda do
      @comment.commentable = User.new
    end.should raise_error(ActiveRecord::AssociationTypeMismatch)
  end

  it 'should allow commentables to be set indirectly' do
    lambda do
      @comment.attributes = {
        :commentable_type => 'Post',
        :commentable_id => 1
      }
    end.should_not raise_error
  end

  it 'should not allow non-commentables to be set indirectly' do
    lambda do
      @comment.attributes = {
        :commentable_type => 'User',
        :commentable_id => 1
      }
    end.should raise_error(ActiveRecord::AssociationTypeMismatch)
  end
end
