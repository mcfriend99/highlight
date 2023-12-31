# highlight

A simple sytax highlighter plugin for Blade's built-in markdown module.

## Requirements

`highlight` has no third-party dependency and works with Blade version `v0.0.86` and above and will not and has no intention of being be compartible with earlier versions.

## Installation

There are many ways you can use highlight in your project.

- You can install highlight via `nyssa` using the command below:
  
  ```
  nyssa install highlight
  ```

  **This is the recommended way to install highlight**

- You can download the [zip release](.) archive from GitHub and add it as a standard package by extracting it into `.blade/libs` directory in your project.
- The simpliest of all, you can just simply just copy the contents of `index.b` into a file of your choice in your project.

> The downside to the last two approaches is that you'll need to manage updates manually &mdash; but with Blade that's not even a big deal.

## Usage

`highlight` is a plugin for the built-in `markdown` module, it requires that you import the markdown module to use it. You can start right away with the default configurations by simply registering it as the highlight function for any markdown instance.

```blade
import markdown
import highlight { highlight }

var md = markdown({
  highlight: highlight(),
})
```

That's all that's required. Code fences and code blocks specifying any of the supported languages will automatically get highlighted.

To use the default theme, add the accompanying `highlight.css` as a stylesheet or its contents to an existing stylesheet in your project.

## Changing the theme

`highlight` allows you to customize the theme for syntax highlighting easily by passing a dictionary of token CSS classes to the `highlight()` function when initialized.

The supported token classes are:

- `string`: The CSS class for strings including their surrounding quotes.
- `interpolation`: The CSS class for interpolations (expressions) within strings if supported by the language.
- `constant`: The CSS class for language constants. For example, for Blade this includes `false` and `nil` if supported by the language.
- `method`: The CSS class for method called on an object if supported by the language. E.g. `instance.method_call()`.
- `function`: The CSS class for functions declaration and call if supported by the language.
- `keyword`: The CSS class for language keywords if supported by the language. For Blade, this includes `if`, `iter` etc.
- `comment`: The CSS class for both single and multiline comments for a language if supported by the language.
- `operator`: The CSS class for operators if supported by the language such as `+`, `-` etc.
- `number`: The CSS class for numbers if supported by the language such as `10.5`, `0x43` etc.
- `prompt`: The CSS class for Blade REPL prompts

For example:

```blade
import markdown
import highlight { highlight }

var md = markdown({
  highlight: highlight({
    number: '#fc9'
  }),
})
```

You should see the CSS class for number highlighted change to the given CSS class.

## Supported Languages

`highlight` currently supports the listed language and markups with their respective code fence and code block hints:

- Blade &mdash; `blade`, `blade-repl` (The REPL mode handles the `%>` and `..` REPL characters) and should be used in the to highlight Blade REPL mode codes.
- HTML &mdash; `html`, `html5`
- Wire &mdash; `wire`
- JSON &mdash; `json`, `json5`

## Contributing a new language

I want to support more languages but can't implement all due to many constraints (and ongoing works on Blade itself) so I am appealing to anyone who is willing to please lets work together to add more language support to this project and rival some of the establised libraries in other languages.

To contribute a new language support you can fork the project, and implement the changes on your fork following the format that currently exists in the codebase then raise a PR when ready. You PR should include a modification to this README file adding the new language to the list of supported languages listed above.

## Licence

`highlight` is released under the MIT license. See [LICENSE](./license) for more details.

