puts "Loading pry"

require "amazing_print"
AmazingPrint.pry!

require 'qd3v/core'

root_module = ::Qd3v::Core

# Add hook to change context to the specified module when Pry starts.
Pry.config.hooks.add_hook(:when_started,
                          :cd_into_module) do |_output, _binding, pry|
  if root_module
    pry.binding_stack.clear
    pry.push_binding(root_module)
    pry.pager.page "Changed context to: #{root_module}"
  else
    pry.pager.page "Warning: Module #{root_module} not defined"
  end
end
