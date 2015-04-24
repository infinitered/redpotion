schema "0001 initial" do
  entity "Contributer" do
    string :name, optional: false

    datetime :created_at
  end
end
