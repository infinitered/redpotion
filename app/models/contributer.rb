class Contributer < CDQManagedObject
  def cell
    {
      cell_class: ContributerCell,
      properties: {
        name: name
      }
    }
  end
end
