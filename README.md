A [Crystal](https://crystal-lang.org) implementation of [Sanemark](https://yujiri.xyz/sanemark). Forked from [markd](https://github.com/icyleaf/markd), an implementation of commonmark.

Because this library was forked from markd, it supports reference links despite that not being in the Commonmark spec. I separated out that part of the spec into [here](spec/fixtures/reference_links.md).

## Quick start

```crystal
require "sanemark"

html = Sanemark.to_html(markdown)
```

Also here are options to configure the parse and render.

```crystal
options = Sanemark::Options.new(safe: true)
Sanemark.to_html(markdown, options)
```

## Options

| Name        | Type   | Default value | Description                                                                                                                                                                     |
| ----------- | ------ | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| time        | `Bool` | false         | render parse cost time during read source, parse blocks, parse inline.                                                                                                          |
| source_pos  | `Bool` | false         | if **true**, source position information for block-level elements<br>will be rendered in the data-sourcepos attribute (for HTML)                                              |
| safe        | `Bool` | false         | if **true**, raw HTML will be escaped                                                                               |
| prettyprint | `Bool` | false         | if **true**, code tags generated by code blocks will have a `prettyprint` class added to them, to be used by [Google code-prettify](https://github.com/google/code-prettify).   |
| base_url    | `URI?` | nil           | if not **nil**, relative URLs of links are resolved against this `URI`. It act's like HTML's `<base href="base_url">` in the context of a Markdown document.                    |

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

## Donate

I take donations via [Paypal](https://paypal.me/yujiri).
