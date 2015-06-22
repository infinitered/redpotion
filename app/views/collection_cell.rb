class CollectionCell < UICollectionViewCell
  def on_load
    find(self).apply_style :collection_cell

    find(self.contentView).tap do |q|
      q.append(UILabel, :title).get.text = rand(100).to_s
    end
  end
end
