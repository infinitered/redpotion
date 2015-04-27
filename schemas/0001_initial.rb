schema "0001 initial" do
  entity "Contributor" do
    string :name, optional: false

    datetime :created_at
  end
end
