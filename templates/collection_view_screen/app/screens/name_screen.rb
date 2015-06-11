class <%= @name_camel_case %>Screen < UICollectionViewController
  include ProMotion::ScreenModule

  title "Your title here"
  stylesheet <%= @name_camel_case %>ScreenStylesheet

  <%= @name.upcase %>_CELL_ID = "<%= @name_camel_case %>Cell"

  def self.new(args = {})
    # Set layout
    layout = UICollectionViewFlowLayout.alloc.init
    s = self.alloc.initWithCollectionViewLayout(layout)
    s.screen_init(args) if s.respond_to?(:screen_init)
    s
  end

  def on_load
    collectionView.tap do |cv|
      cv.registerClass(<%= @name_camel_case %>Cell, forCellWithReuseIdentifier: <%= @name.upcase %>_CELL_ID)
      cv.delegate = self
      cv.dataSource = self
      cv.allowsSelection = true
      cv.allowsMultipleSelection = false
      find(cv).apply_style :collection_view
    end
  end

  def numberOfSectionsInCollectionView(view)
    1
  end

  def collectionView(view, numberOfItemsInSection: section)
    200
  end

  def collectionView(view, cellForItemAtIndexPath: index_path)
    view.dequeueReusableCellWithReuseIdentifier(<%= @name.upcase %>_CELL_ID, forIndexPath: index_path).tap do |cell|
      self.rmq.build(cell) unless cell.reused

      # Update cell's data here
    end
  end

  def collectionView(view, didSelectItemAtIndexPath: index_path)
    cell = view.cellForItemAtIndexPath(index_path)
    puts "Selected at section: #{index_path.section}, row: #{index_path.row}"
  end

  # Remove the following if you're only using portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end
end
