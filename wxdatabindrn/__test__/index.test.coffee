{clearBindLR, chompBindLR, convert, isBind} = require '../index'


# isBind
test 'isBind => {{bind}}', ()-> 
    expect(isBind('{{bind}}')).toBe true

test 'isBind not bind => bind', ()->
    expect(isBind('bind')).toBe false

test 'isBind left => {{bind}}right', ()->
    expect(isBind('{{bind}}right')).toBe true
test 'isBind right => left{{bind}}', ()->
    expect(isBind('left{{bind}}')).toBe true

test 'isBind center => left{{bind}}right', ()->
    expect(isBind('left{{bind}}right')).toBe true

# chompBindLR
test 'chompBindLR => {{bind}}', ()->
    expect(chompBindLR('{{bind}}')).toBe "{bind}"

# clearBindLR
test 'clearBindLR => {{bind}}', ()->
    expect(clearBindLR('{{bind}}')).toBe "bind"

# css databind
test 'width:{{width}}', ()->
    expect(convert('width:{{width}}')).toBe "'width:'+(width)+''"

test '{{width}}:{{value}}', ()->
    expect(convert('{{width}}:{{value}}')).toBe "''+(width)+':'+(value)+''"

# attr databind
test '{{true}}', ()->
    expect(convert('{{true}}')).toBe "{true}"

test 'This is a {{text}}', ()->
    expect(convert('This is a {{text}}')).toBe "'This is a '+(text)+''"


test '{{text}} is a word', ()->
    expect(convert('{{text}} is a word')).toBe "''+(text)+' is a word'"



