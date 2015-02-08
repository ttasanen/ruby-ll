module LL
  ##
  # Parser driver for generated (or hand written) parsers.
  #
  class Driver
    ##
    # Error method that is called when no rule was found for a table index.
    #
    # @param [Fixnum] stack_value
    # @param [Array] token
    #
    def stack_input_error(stack_value, token)
      type = token[0].inspect

      raise ParserError, "Unexpected rule #{stack_value} for #{type}"
    end

    ##
    # Error method that is called when the stack has been consumed but there's
    # still input being sent to the parser.
    #
    # @param [Array] token
    #
    def unexpected_input_error(token)
      raise(
        ParserError,
        "Received token #{token[0]} but there's nothing left to parse"
      )
    end

    ##
    # Error method that is called when an invalid terminal was specified as the
    # input.
    #
    # @param [Fixnum] got_id The ID of the received terminal.
    # @param [Fixnum] expected_id The ID of the expected terminal.
    #
    def invalid_terminal_error(got_id, expected_id)
      terminals = self.class::CONFIG.terminals
      expected  = terminals[expected_id]

      if got_id == -1
        raise ParserError, "Reached EOF while expecting terminal #{expected}"
      else
        got = terminals[got_id]

        raise ParserError, "Invalid terminal #{got}, expected #{expected}"
      end
    end
  end # Driver
end # LL
