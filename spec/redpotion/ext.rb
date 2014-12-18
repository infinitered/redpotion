describe 'Redpotion ext' do
  it "should allow you to get a new color from an existing color with 'with'" do
    trans_black = UIColor.blackColor.with(alpha: 0.5)
    trans_black.should.equal(UIColor.colorWithRed(0, green: 0, blue: 0, alpha: 0.5))
  end
end
