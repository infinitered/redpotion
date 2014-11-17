module RubyMotionQuery
  class App
    class << self
      def current_screen(root_view_controller = nil)
        current_view_controller root_view_controller
      end
    end
  end
end
