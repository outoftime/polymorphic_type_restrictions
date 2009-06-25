require File.join(File.dirname(__FILE__), 'spec_helper')

describe PolymorphicTypeRestrictions do
  context 'with restricted polymorphic association' do
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

    it 'should raise an AssociationTypeError if type doesn\'t exist' do
      lambda do
        @comment.attributes = {
          :commentable_type => 'Bogus',
          :commentable_id => 1
        }
      end.should raise_error(ActiveRecord::AssociationTypeNameError)
    end
  end

  context 'without restricted polymorphic association' do
    before :each do
      @photo = Photo.new
    end

    it 'should raise an AssociationTypeError if type doesn\'t exist' do
      lambda do
        @photo.attributes = { 
          :attached_type => 'Bogus',
          :attached_id => 1
        }
      end.should raise_error(ActiveRecord::AssociationTypeNameError)
    end
  end
end
