describe 'UITableViewController' do
  describe 'properly sets the stylesheet' do
    class TestTableScreen < PM::TableScreen
      stylesheet ApplicationStylesheet

      attr_accessor :stylesheet_during_table_data
      def table_data
        self.stylesheet_during_table_data = stylesheet
        {}
      end
    end

    it 'sets the stylesheet properly' do
      table_screen = TestTableScreen.new(animated:false)
      table_screen.stylesheet_during_table_data.is_a?(ApplicationStylesheet).should.be.true
    end
  end
end
