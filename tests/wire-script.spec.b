import ..index as _highlight

var highlight = _highlight.highlight()

def wire(text) {
  return highlight(text, 'wire')
}

describe('Blade script highlight test', @() {
  it('should highlight complete tags', @() {
    expect(wire('<p></p>')).to_be(
      '<span class="k">&lt;p&gt;</span><span class="k">&lt;/p&gt;</span>'
    )
    
    expect(wire('<em>Nevada</em>')).to_be(
      '<span class="k">&lt;em&gt;</span>Nevada<span class="k">&lt;/em&gt;</span>'
    )

    expect(wire('<img src="picture.jpg" />')).to_be(
      '<span class="k">&lt;img <span class="o">src</span>=' +
      '<span class="s">"picture.jpg"</span> /&gt;</span>'
    )

    expect(wire('<meta charset="utf-8">')).to_be(
      '<span class="k">&lt;meta <span class="o">charset</span>=' +
      '<span class="s">"utf-8"</span>&gt;</span>'
    )
  })

  it('should highlight nested tags', @() {
    expect(wire('<p><b></b></p>')).to_be(
      '<span class="k">&lt;p&gt;</span><span class="k">&lt;b&gt;</span>' +
      '<span class="k">&lt;/b&gt;</span><span class="k">&lt;/p&gt;</span>'
    )

    expect(wire('<p><b>Content</b></p>')).to_be(
      '<span class="k">&lt;p&gt;</span><span class="k">&lt;b&gt;</span>' +
      'Content<span class="k">&lt;/b&gt;</span><span class="k">&lt;/p&gt;</span>'
    )

    expect(wire('<p><b>Content</b></p>')).to_be(
      '<span class="k">&lt;p&gt;</span><span class="k">&lt;b&gt;</span>' +
      'Content<span class="k">&lt;/b&gt;</span><span class="k">&lt;/p&gt;</span>'
    )

    expect(wire(
      '<!DOCTYPE html>\n<html lang="en">\n<head>\n  <meta charset="UTF-8">\n' +
      '  <meta name="viewport" content="width=device-width, initial-scale=1.0">\n' +
      '  <title>Document</title>\n</head>n<body>\n\n</body>\n</html>'
    )).to_be(
      '<span class="k">&lt;!DOCTYPE html&gt;</span>\n<span class="k"' +
      '>&lt;html <span class="o">lang</span>=<span class="s">"en"</span>' +
      '&gt;</span>\n<span class="k">&lt;head&gt;</span>\n  <span class="k">' +
      '&lt;meta <span class="o">charset</span>=<span class="s">"UTF-8"' +
      '</span>&gt;</span>\n  <span class="k">&lt;meta <span class="o">' +
      'name</span>=<span class="s">"viewport"</span> <span class="o">content' +
      '</span>=<span class="s">"<span class="o">width</span>=device-width, ' +
      '<span class="o">initial-scale</span>=<span class="n">1.0</span>"</span>' +
      '&gt;</span>\n  <span class="k">&lt;title&gt;</span>Document<span ' +
      'class="k">&lt;/title&gt;</span>\n<span class="k">&lt;/head&gt;</span>' +
      'n<span class="k">&lt;body&gt;</span>\n\n<span class="k">&lt;/body&gt;' +
      '</span>\n<span class="k">&lt;/html&gt;</span>'
    )
  })
})
