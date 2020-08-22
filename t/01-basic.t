use Test;
use FixedInt;

plan 24;

my \foo = FixedInt.new(:8bit);

is(foo -= 1, 255, '8 bit negative ok');
is(foo.signed, -1, '8 bit signed ok');
foo += 15;
is(foo.=ror(2), 131, '8 bit rotate right ok');
is(foo.=rol(6), 224, '8 bit rotate left ok');
is(foo +>= 2, 56, '8 bit bit shift right ok');
is(foo +<= 4, 128, '8 bit bit shift left ok');
is(foo.=C1, 127, '8 bit ones complement ok');
is(foo.=C2, 129, '8 bit twos complement ok');
is(foo.signed, -127, '8 bit signed ok');
is(foo.bin, "0b10000001", '8 bit binary IntStr ok');
is(foo.oct, "0o0201", '8 bit octal IntStr ok');
is(foo.hex, "0x81", '8 bit hex IntStr ok');


my \bar = FixedInt.new(:19bit);

is(bar -= 1, 524287, '19 bit negative ok');
is(bar.signed, -1, '19 bit signed ok');
bar += 15;
is(bar.=ror(2), 262147, '19 bit rotate right ok');
is(bar.=rol(6), 224, '19 bit rotate left ok');
is(bar +>= 2, 56, '19 bit bit shift right ok');
is(bar +<= 4, 896, '19 bit bit shift left ok');
is(bar.=C1, 523391, '19 bit ones complement ok');
is(bar.C2, 897, '19 bit twos complement ok');
is(bar.signed, -897, '19 bit signed ok');
is(bar.bin, "0b1111111110001111111", '19 bit binary IntStr ok');
is(bar.oct, "0o001776177", '19 bit octal IntStr ok');
is(bar.hex, "0x7FC7F", '19 bit hex IntStr ok');

done-testing;
