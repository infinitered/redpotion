describe 'UICollectionViewController' do

  before do
    @controller = CollectionScreen.new
  end

  it "should have sections" do
    @controller.numberOfSectionsInCollectionView(@controller.collectionView).should == 1
  end

  it "should have cells" do
    @controller.collectionView(@controller.collectionView, numberOfItemsInSection: 0).should == 200
  end

  it "should have cells of the proper class" do
    path = NSIndexPath.indexPathForRow(0, inSection:0)
    cell = @controller.collectionView(@controller.collectionView, cellForItemAtIndexPath: path)

    cell.class.should == CollectionCell
  end

  it "should provide a reference back to the collection view from the cell" do
    path = NSIndexPath.indexPathForRow(0, inSection:0)
    cell = @controller.collectionView(@controller.collectionView, cellForItemAtIndexPath: path)

    cell.collection_screen.should == @controller
  end

end
