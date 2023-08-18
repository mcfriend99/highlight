import ..index as _highlight

var highlight = _highlight.highlight()

def wire(text) {
  return highlight(text, 'wire')
}

describe('Wire and HTML lexical highlight test', @() {
  
  it('should highlight tags correctly', @() {
    expect(wire('<p>')).to_be('<span class="k">&lt;p&gt;</span>')
    expect(wire('< p>')).to_be('< p>')
    expect(wire('<p >')).to_be('<span class="k">&lt;p &gt;</span>')
    expect(wire('</p>')).to_be('<span class="k">&lt;/p&gt;</span>')
  })

  it('should highlight comments correctly!', @() {
    expect(wire('<!---->')).to_be('<span class="c">&lt;!----&gt;</span>')
    expect(wire('<!-- Hi -->')).to_be('<span class="c">&lt;!-- Hi --&gt;</span>')
  })

  it('should highlight attribute correctly', @() {
    expect(wire('id=')).to_be('id=')
    expect(wire('x-id=')).to_be('x-id=')
    expect(wire('<p id=>')).to_be('<span class="k">&lt;p <span class="o">id</span>=&gt;</span>')
    expect(wire('<p x-if= >')).to_be('<span class="k">&lt;p <span class="o">x-if</span>= &gt;</span>')
    expect(wire('<p x-if== >')).to_be('<span class="k">&lt;p <span class="o">x-if</span>== &gt;</span>')
  })

  it('should highlight value correctly', @() {
    expect(wire('id=5')).to_be('id=5')
    expect(wire('id==5')).to_be('id==5')
    expect(wire('<p id=5>')).to_be('<span class="k">&lt;p <span class="o">id</span>=<span class="n">5</span>&gt;</span>')
    expect(wire('<p id="my-id">')).to_be('<span class="k">&lt;p <span class="o">id</span>=<span class="s">"my-id"</span>&gt;</span>')
    expect(wire("<p id='my-id'>")).to_be('<span class="k">&lt;p <span class="o">id</span>=<span class="s">\'my-id\'</span>&gt;</span>')
    expect(wire("<p x-for='my_val'>")).to_be('<span class="k">&lt;p <span class="o">x-for</span>=<span class="s">\'my_val\'</span>&gt;</span>')
    expect(wire("<p id==5>")).to_be('<span class="k">&lt;p <span class="o">id</span>==5&gt;</span>')
  })

  it('should treat escape in values correctly!', @() {
    expect(wire('<p id="\\"that\'s\\" it">')).to_be(
      '<span class="k">&lt;p <span class="o">id</span>=<span class="s">"\\"that\'s\\" it"</span>&gt;</span>'
    )
  })

  it('should retain tag content', @() {
    expect(wire('<p>some content</p>')).to_be('<span class="k">&lt;p&gt;</span>some content<span class="k">&lt;/p&gt;</span>')
    expect(wire('<p>some <> content</p>')).to_be('<span class="k">&lt;p&gt;</span>some <> content<span class="k">&lt;/p&gt;</span>')
    expect(wire('<p>some id=15</p>')).to_be('<span class="k">&lt;p&gt;</span>some id=15<span class="k">&lt;/p&gt;</span>')
    expect(wire('<p>some id=15 content</p>')).to_be('<span class="k">&lt;p&gt;</span>some id=15 content<span class="k">&lt;/p&gt;</span>')
    expect(wire('<p>some id="value"</p>')).to_be('<span class="k">&lt;p&gt;</span>some id="value"<span class="k">&lt;/p&gt;</span>')
    expect(wire('<p>some id="value" content</p>')).to_be('<span class="k">&lt;p&gt;</span>some id="value" content<span class="k">&lt;/p&gt;</span>')
  })
})
