schema "0002 add city names" do
  entity "Contributor" do
    string :name, optional: false
    string :city, optional: true

    datetime :created_at
  end
end
