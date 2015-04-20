if RUBYMOTION_ENV == "development"
  module Kernel
    def live(interval = 1.0, debug=false)
      rmq_live_stylesheets interval, debug
    end

    def enable_live_stylesheets(interval)
      enable_rmq_live_stylesheets interval
    end
  end
end
