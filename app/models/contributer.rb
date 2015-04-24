class Contributer < CDQManagedObject
  scope :starts_with_s, where(:name).begins_with('s').sort_by(:name)

  def cell
    {
      cell_class: ContributerCell,
      properties: {
        name: name
      }
    }
  end
end
