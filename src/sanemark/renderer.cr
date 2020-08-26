module Sanemark
  abstract class Renderer
    def initialize(@options = Options.new)
      @output_io = String::Builder.new
      @last_output = "\n"
    end

    def out(string : String)
      lit(escape(string))
    end

    def lit(string : String)
      @output_io << string
      @last_output = string
    end

    def cr
      lit("\n") if @last_output != "\n"
    end

    private ESCAPES = {
      '&' => "&amp;",
      '"' => "&quot;",
      '<' => "&lt;",
      '>' => "&gt;",
    }

    def escape(text)
      # If we can determine that the text has no escape chars
      # then we can return the text as is, avoiding an allocation
      # and a lot of processing in `String#gsub`.
      if has_escape_char?(text)
        text.gsub(ESCAPES)
      else
        text
      end
    end

    private def has_escape_char?(text)
      text.each_byte do |byte|
        case byte
        when '&', '"', '<', '>'
          return true
        else
          next
        end
      end
      false
    end

    def render(document : Node)
      Utils.timer("renderering", @options.time) do
        walker = document.walker
        while event = walker.next
          node, entering = event
          case node.type
          when Node::Type::Heading
            heading(node, entering)
          when Node::Type::List
            list(node, entering)
          when Node::Type::Item
            item(node, entering)
          when Node::Type::BlockQuote
            block_quote(node, entering)
          when Node::Type::ThematicBreak
            thematic_break(node, entering)
          when Node::Type::CodeBlock
            code_block(node, entering)
          when Node::Type::Code
            code(node, entering)
          when Node::Type::HTMLBlock
            html_block(node, entering)
          when Node::Type::HTMLInline
            html_inline(node, entering)
          when Node::Type::Paragraph
            paragraph(node, entering)
          when Node::Type::OpenEmphasis
            open_emphasis(node)
          when Node::Type::CloseEmphasis
            close_emphasis(node)
          when Node::Type::OpenStrong
            open_strong(node)
          when Node::Type::CloseStrong
            close_strong(node)
          when Node::Type::SoftBreak
            soft_break(node, entering)
          when Node::Type::LineBreak
            line_break(node, entering)
          when Node::Type::Link
            link(node, entering)
          when Node::Type::Image
            image(node, entering)
          else
            text(node, entering)
          end
        end
      end

      @output_io.to_s.sub("\n", "")
    end
  end
end

require "./renderers/*"
