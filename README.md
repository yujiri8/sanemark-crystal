A [Crystal](https://crystal-lang.org) implementation of [Sanemark](https://yujiri.xyz/sanemark). Forked from [markd](https://github.com/icyleaf/markd), an implementation of commonmark.

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
| spoilers    | `Bool` | false         | Enable spoilers, delimited by >! and !<. They are inline elements that have the same precedence as asterisks.                                                                 |
| heading_ids | `Bool` | false         | Add `id` attributes to heading elements consisting of a slug of their plaintext.                                                                                              |
| time        | `Bool` | false         | render time spent during block parsing, inline parsing, and rendering.                                                                                                        |

## Advanced

If you want to use a custom renderer, it can!

```crystal

class CustomRenderer < Sanemark::Renderer

  def open_strong(node)
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

My cashapp tag is $yujiri.
