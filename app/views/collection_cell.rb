class CollectionCell < UICollectionViewCell
  attr_accessor :collection_screen

  def on_load
    find(self).apply_style :collection_cell

    find(self.contentView).tap do |q|
      q.append(UILabel, :title).get.text = rand(100).to_s
    end
  end
end
