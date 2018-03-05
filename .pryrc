if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

Pry.commands.alias_command 'wh', 'whereami'

Pry.config.color = true
Pry.config.editor = 'nvim'

