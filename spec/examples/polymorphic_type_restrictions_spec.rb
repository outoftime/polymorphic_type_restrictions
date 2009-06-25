require File.join(File.dirname(__FILE__), 'spec_helper')

describe PolymorphicTypeRestrictions do
  describe 'with restricted polymorphic association' do
    before :each do
      @comment = Comment.new
    end

    it 'should allow commentables to be set directly' do
      post = Post.new
      lambda { @comment.commentable = post }.should_not raise_error
      @comment.commentable.should == post
    end

    it 'should allow photos to be set directly' do
      photo = Photo.new
      lambda { @comment.commentable = photo }.should_not raise_error
      @comment.commentable.should == photo
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
      @comment.commentable_type.should == 'Post'
      @comment.commentable_id.should == 1
    end

    it 'should allow photos to be set indirectly' do
      lambda do
        @comment.attributes = {
          :commentable_type => 'Photo',
          :commentable_id => 1
        }
      end.should_not raise_error
      @comment.commentable_type.should == 'Photo'
      @comment.commentable_id.should == 1
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

  describe 'without restricted polymorphic association' do
    before :each do
      @photo = Photo.new
    end

    it 'should not raise an AssociationTypeError for normal input' do
      lambda do
        @photo.attributes = {
          :attached_type => 'Post',
          :attached_id => 1
        }
      end.should_not raise_error
      @photo.attached_type.should == 'Post'
      @photo.attached_id.should == 1
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
