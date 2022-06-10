module Quark
  module Command
    # run command
    def self.run_quark(args)
      text = args[0]?
      Quark::Run.get_path(text)
    end
  end
end
