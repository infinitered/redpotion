class Contributer < CDQManagedObject
  scope :all, sort_by(:name)

  def cell
    {
      cell_class: ContributerCell,
      properties: {
        name: name
      }
    }
  end
end
