import ..index as _highlight

var highlight = _highlight.highlight()

def blade(text) {
  return highlight(text, 'blade')
}

describe('Blade lexical highlight test', @() {
  it('should highlight string tokens correctly!', @() {
    expect(blade("'Hello, World'")).to_be('<span style="color:#690">\'Hello, World\'</span>')
    expect(blade('"Hello, World"')).to_be('<span style="color:#690">"Hello, World"</span>')
  })

  it('should highlight escaped string tokens correctly!', @() {
    expect(blade('"\\"that\'s\\" it"')).to_be('<span style="color:#690">"\\"that\'s\\" it"</span>')
  })

  it('should highlight interpolation tokens correctly!', @() {
    expect(blade("'\${name}'")).to_be('<span style="color:#690">\'<span style="color:#00bcd4">\${name}</span>\'</span>')
  })

  it('should highlight constant tokens correctly!', @() {
    expect(blade('nil')).to_be('<span style="color:#ff9800">nil</span>')
    expect(blade('true')).to_be('<span style="color:#ff9800">true</span>')
    expect(blade('false')).to_be('<span style="color:#ff9800">false</span>')
    expect(blade('parent')).to_be('<span style="color:#ff9800">parent</span>')
    expect(blade('self')).to_be('<span style="color:#ff9800">self</span>')
    expect(blade('self.test')).to_be('<span style="color:#ff9800">self</span>.test')
  })

  it('should highlight numeric tokens correctly!', @() {
    expect(blade('15')).to_be('<span style="color:#905">15</span>')
    expect(blade('15.25')).to_be('<span style="color:#905">15.25</span>')
    expect(blade('-15.25')).to_be('<span style="color:#9a6e3a">-</span><span style="color:#905">15.25</span>')
    expect(blade('0xacd')).to_be('<span style="color:#905">0xacd</span>')
    expect(blade('0xACD')).to_be('<span style="color:#905">0xACD</span>')
    expect(blade('0xACDG')).to_be('<span style="color:#905">0xACD</span>G')
    expect(blade('0c644')).to_be('<span style="color:#905">0c644</span>')
    expect(blade('0c6448')).to_be('<span style="color:#905">0c644</span><span style="color:#905">8</span>')
    expect(blade('0b10010')).to_be('<span style="color:#905">0b10010</span>')
    expect(blade('33.413E-10')).to_be(
      '<span style="color:#905">33.413</span>E<span style="color:#9a6e3a">-</span><span style="color:#905">10</span>'
    )
  })

  it('should highlight function and method tokens correctly!', @() {
    expect(blade('method\()')).to_be('method\()')
    expect(blade('method()')).to_be('<span style="color:#ff5722">method</span>()')
    expect(blade('x.method()')).to_be('x.<span style="color:#ff5722;font-style:italic">method</span>()')
    expect(blade('x.method.()')).to_be('x.method.()')
    expect(blade('1method()')).to_be('<span style="color:#905">1</span><span style="color:#ff5722">method</span>()')
  })

  it('should highlight operator tokens correctly!', @() {
    expect(blade('+')).to_be('<span style="color:#9a6e3a">+</span>')
    expect(blade('-')).to_be('<span style="color:#9a6e3a">-</span>')
    expect(blade('*')).to_be('<span style="color:#9a6e3a">*</span>')
    expect(blade('/')).to_be('<span style="color:#9a6e3a">/</span>')
    expect(blade('~')).to_be('<span style="color:#9a6e3a">~</span>')
    expect(blade('^')).to_be('<span style="color:#9a6e3a">^</span>')
    expect(blade('!')).to_be('<span style="color:#9a6e3a">!</span>')
    expect(blade('=')).to_be('<span style="color:#9a6e3a">=</span>')
    expect(blade('@')).to_be('<span style="color:#9a6e3a">@</span>')

    # compound operators
    expect(blade('..')).to_be('<span style="color:#9a6e3a">..</span>')
    expect(blade('and')).to_be('<span style="color:#9a6e3a">and</span>')
    expect(blade('or')).to_be('<span style="color:#9a6e3a">or</span>')

    expect(blade('&')).to_be('&')
    expect(blade('|')).to_be('|')
    expect(blade('>')).to_be('&gt;')
    expect(blade('<')).to_be('&lt;')

    # * and / should only be highlighted as operators when not used together with one another.
    expect(blade('/*')).to_be('/*')
    expect(blade('*/')).to_be('*/')

    # range operator should be not be highligthed if there's a space between the two dots.
    expect(blade('. .')).to_be('. .')
  })

  it('should highlight keyword tokens correctly!', @() {
    expect(blade('as')).to_be('<span style="color:#2196f3">as</span>')
    expect(blade('assert')).to_be('<span style="color:#2196f3">assert</span>')
    expect(blade('break')).to_be('<span style="color:#2196f3">break</span>')
    expect(blade('catch')).to_be('<span style="color:#2196f3">catch</span>')
    expect(blade('class')).to_be('<span style="color:#2196f3">class</span>')
    expect(blade('continue')).to_be('<span style="color:#2196f3">continue</span>')

    expect(blade('def')).to_be('<span style="color:#2196f3">def</span>')
    expect(blade('default')).to_be('<span style="color:#2196f3">default</span>')
    expect(blade('die')).to_be('<span style="color:#2196f3">die</span>')
    expect(blade('do')).to_be('<span style="color:#2196f3">do</span>')
    expect(blade('echo')).to_be('<span style="color:#2196f3">echo</span>')
    expect(blade('else')).to_be('<span style="color:#2196f3">else</span>')
    expect(blade('finally')).to_be('<span style="color:#2196f3">finally</span>')
    expect(blade('for')).to_be('<span style="color:#2196f3">for</span>')

    expect(blade('if')).to_be('<span style="color:#2196f3">if</span>')
    expect(blade('import')).to_be('<span style="color:#2196f3">import</span>')
    expect(blade('in')).to_be('<span style="color:#2196f3">in</span>')
    expect(blade('iter')).to_be('<span style="color:#2196f3">iter</span>')
    expect(blade('return')).to_be('<span style="color:#2196f3">return</span>')
    expect(blade('static')).to_be('<span style="color:#2196f3">static</span>')
    expect(blade('try')).to_be('<span style="color:#2196f3">try</span>')

    expect(blade('using')).to_be('<span style="color:#2196f3">using</span>')
    expect(blade('var')).to_be('<span style="color:#2196f3">var</span>')
    expect(blade('when')).to_be('<span style="color:#2196f3">when</span>')
    expect(blade('while')).to_be('<span style="color:#2196f3">while</span>')
  })

  it('should highlight comment tokens correctly!', @() {
    expect(blade('# some useful comment')).to_be('<span style="color:slategray"># some useful comment</span>')
    expect(blade('/* some useful comment */')).to_be('<span style="color:slategray">/* some useful comment */</span>')

    expect(blade('/*
    some useful comment 
    */')).to_be('<span style="color:slategray">/*
    some useful comment 
    */</span>')

    # single line nested in block comment.
    expect(blade('/*
    # some useful comment 
    */')).to_be('<span style="color:slategray">/*
    # some useful comment 
    */</span>')

    # block nested in single line comment
    expect(blade('# some /* useful */ comment')).to_be('<span style="color:slategray"># some /* useful */ comment</span>')
  })
})
