import ..index as _highlight

var highlight = _highlight.highlight()

def wire(text) {
  return highlight(text, 'wire')
}

describe('Blade script highlight test', @() {
  it('should highlight complete tags', @() {
    expect(wire('<p></p>')).to_be(
      '<span style="color:#2196f3">&lt;p&gt;</span><span style="color:#2196f3">&lt;/p&gt;</span>'
    )
    
    expect(wire('<em>Nevada</em>')).to_be(
      '<span style="color:#2196f3">&lt;em&gt;</span>Nevada<span style="color:#2196f3">&lt;/em&gt;</span>'
    )

    expect(wire('<img src="picture.jpg" />')).to_be(
      '<span style="color:#2196f3">&lt;img <span style="color:#9a6e3a">src</span>=' +
      '<span style="color:#690">"picture.jpg"</span> /&gt;</span>'
    )

    expect(wire('<meta charset="utf-8">')).to_be(
      '<span style="color:#2196f3">&lt;meta <span style="color:#9a6e3a">charset</span>=' +
      '<span style="color:#690">"utf-8"</span>&gt;</span>'
    )
  })

  it('should highlight nested tags', @() {
    expect(wire('<p><b></b></p>')).to_be(
      '<span style="color:#2196f3">&lt;p&gt;</span><span style="color:#2196f3">&lt;b&gt;</span>' +
      '<span style="color:#2196f3">&lt;/b&gt;</span><span style="color:#2196f3">&lt;/p&gt;</span>'
    )

    expect(wire('<p><b>Content</b></p>')).to_be(
      '<span style="color:#2196f3">&lt;p&gt;</span><span style="color:#2196f3">&lt;b&gt;</span>' +
      'Content<span style="color:#2196f3">&lt;/b&gt;</span><span style="color:#2196f3">&lt;/p&gt;</span>'
    )

    expect(wire('<p><b>Content</b></p>')).to_be(
      '<span style="color:#2196f3">&lt;p&gt;</span><span style="color:#2196f3">&lt;b&gt;</span>' +
      'Content<span style="color:#2196f3">&lt;/b&gt;</span><span style="color:#2196f3">&lt;/p&gt;</span>'
    )

    expect(wire(
      '<!DOCTYPE html>\n<html lang="en">\n<head>\n  <meta charset="UTF-8">\n' +
      '  <meta name="viewport" content="width=device-width, initial-scale=1.0">\n' +
      '  <title>Document</title>\n</head>n<body>\n\n</body>\n</html>'
    )).to_be(
      '<span style="color:#2196f3">&lt;!DOCTYPE html&gt;</span>\n<span style="color:#2196f3"' +
      '>&lt;html <span style="color:#9a6e3a">lang</span>=<span style="color:#690">"en"</span>' +
      '&gt;</span>\n<span style="color:#2196f3">&lt;head&gt;</span>\n  <span style="color:#2196f3">' +
      '&lt;meta <span style="color:#9a6e3a">charset</span>=<span style="color:#690">"UTF-8"' +
      '</span>&gt;</span>\n  <span style="color:#2196f3">&lt;meta <span style="color:#9a6e3a">' +
      'name</span>=<span style="color:#690">"viewport"</span> <span style="color:#9a6e3a">content' +
      '</span>=<span style="color:#690">"<span style="color:#9a6e3a">width</span>=device-width, ' +
      '<span style="color:#9a6e3a">initial-scale</span>=<span style="color:#905">1.0</span>"</span>' +
      '&gt;</span>\n  <span style="color:#2196f3">&lt;title&gt;</span>Document<span ' +
      'style="color:#2196f3">&lt;/title&gt;</span>\n<span style="color:#2196f3">&lt;/head&gt;</span>' +
      'n<span style="color:#2196f3">&lt;body&gt;</span>\n\n<span style="color:#2196f3">&lt;/body&gt;' +
      '</span>\n<span style="color:#2196f3">&lt;/html&gt;</span>'
    )
  })
})
