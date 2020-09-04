A [Crystal](https://crystal-lang.org) implementation of [Sanemark](https://yujiri.xyz/sanemark). Forked from [markd](https://github.com/icyleaf/markd), an implementation of commonmark.

Because this library was forked from markd, the options besides `allow_html` are from that.

*There are a few failing tests right now because I've changed the way emphasis works and I'm not quite sure what I* want *the behavior to be in some edge cases.*

## Quick start

```crystal
require "sanemark"

html = Sanemark.to_html(markdown)

# With options
options = Sanemark::Options.new(safe: true)
Sanemark.to_html(markdown, options)
```

## Options

| Name        | Type   | Default value | Description                                                                                                                                                                   |
| ----------- | ------ | ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| allow_html  | `Bool` | false         | let HTML through according to the Sanemark spec. By default, all HTML is escaped. This option also turns off sanitization of dangerous link protocols.                        |
| time        | `Bool` | false         | render parse cost time during read source, parse blocks, parse inline.                                                                                                        |
| source_pos  | `Bool` | false         | if **true**, source position information for block-level elements will be rendered in the data-sourcepos attribute (for HTML)                                                 |
| prettyprint | `Bool` | false         | if **true**, code tags generated by code blocks will have a `prettyprint` class added to them, to be used by [Google code-prettify](https://github.com/google/code-prettify). |

## Advanced

If you want to use a custom renderer, it can!

```crystal

class CustomRenderer < Sanemark::Renderer

  def strong(node, entering)
  end

  # more methods following in render.
end

options = Sanemark::Options.new(time: true)
document = Sanemark::Parser.parse(markdown, options)
renderer = CustomRenderer.new(options)

html = renderer.render(document)
```

This should be better documented, but for now it isn't.

## Donate

I take donations via [Paypal](https://paypal.me/yujiri).
