module Quark
  module Command
    # run quark hook
    def self.run_hook(args)
      shell = args[0]?

      # check if hook exists
      has_hook =
        Dir[File.expand_path(File.join("..", "hook", "*"), __DIR__)]
          .map { |file| File.basename(file) }
          .includes?("hook.#{shell}")

      if has_hook
        # get hook
        puts File.read(File.expand_path(
          File.join("..", "hook", "hook.#{shell}"), __DIR__
        ))
      else
        error("hook for `#{shell}` does not exist", 1)
      end
    end
  end
end
