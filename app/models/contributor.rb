class Contributor < CDQManagedObject
  scope :starts_with_s, where(:name).begins_with('s').sort_by(:name)

  def cell
    {
      cell_class: ContributorCell,
      properties: {
        name: name
      }
    }
  end
end
