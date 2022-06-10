module Quark
  module Command
    # run hook
    def self.run_hook(args)
      item = args[0]?
      Quark::Hook.run(item)
    end
  end
end
