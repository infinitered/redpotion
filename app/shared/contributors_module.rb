module ContributorsModule
  
  def contributors
    [{
      name: 'twerth',
      city: "San Francisco"
    }, {
      name: 'squidpunch',
      city: nil
    }, {
      name: 'GantMan',
      city: "New Orleans, LA"
    }, {
      name: 'shreeve',
      city: nil
    }, {
      name: 'chunlea',
      city: 'Shandong, China'
    }, {
      name: 'markrickert',
      city: 'Everywhere, USA'
    }]
  end

  def init_contributors
    Contributor.destroy_all
    contributors.each do |c|
      Contributor.new(c)
    end
    cdq.save
  end

end
