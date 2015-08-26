if RUBYMOTION_ENV == "development"
  class TopLevel
    def live(interval = 1.0, debug=false)
      rmq_live_stylesheets interval, debug
    end

    def enable_live_stylesheets(interval)
      enable_rmq_live_stylesheets interval
    end

    def open(screen, args={})
      find.screen.open(screen, args)
    end

    def close(args={})
      find.screen.close(args)
    end
  end
end
