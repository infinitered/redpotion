class CollectionScreen < UICollectionViewController
  include ProMotion::ScreenModule

  stylesheet CollectionScreenStylesheet
  title 'Collection View'
  COLLECTION_CELL_ID = "CollectionCell"

  def self.new(args = {})
    layout = UICollectionViewFlowLayout.alloc.init
    s = self.alloc.initWithCollectionViewLayout(layout)
    s.screen_init(args) if s.respond_to?(:screen_init)
    s
  end

  def on_load
    collectionView.tap do |cv|
      cv.registerClass(CollectionCell, forCellWithReuseIdentifier: COLLECTION_CELL_ID)
      cv.delegate = self
      cv.dataSource = self
      cv.allowsSelection = true
      cv.allowsMultipleSelection = false
      find(cv).apply_style :collection_view
    end
  end

  # Remove if you are only supporting portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end

  def numberOfSectionsInCollectionView(view)
    1
  end

  def collectionView(view, numberOfItemsInSection: section)
    200
  end

  def collectionView(view, cellForItemAtIndexPath: index_path)
    view.dequeueReusableCellWithReuseIdentifier(COLLECTION_CELL_ID, forIndexPath: index_path).tap do |cell|
      build(cell) unless cell.reused

      # Update cell's data here
    end
  end

  def collectionView(view, didSelectItemAtIndexPath: index_path)
    cell = view.cellForItemAtIndexPath(index_path)
    puts "Selected at section: #{index_path.section}, row: #{index_path.row}"
  end

end

