NAME
====

FixedInt - Unsigned fixed sized Integers

SYNOPSIS
========

```raku
use FixedInt;

my \fixedint = FixedInt.new(:8bit);

say fixedint; # 0

say fixedint -= 12;   # 244
say fixedint.signed;  # -12
say fixedint.bin;     # 0b11110100
say fixedint.hex;     # 0xF4

say fixedint += 2500; # 184
say fixedint.signed;  # -72
say fixedint.bin;     # 0b10111000
say fixedint.hex;     # 0xB8
```

DESCRIPTION
===========

FixedInt provides an easy way to work with fixed-sized unsigned integers in Raku. Rakus Integers by default are unfixed, arbitrary size. Doing unsigned fixed-size bitwise operations requires a bunch of extra bookkeeping. This module hides that bookkeeping behind an interface.

One major caveat to be aware of when using this module. The class instance **may not** be instantiated in a $ sigiled variable.

Raku $ sigiled scalar variables do not implement a STORE method, but instead do direct assignment; and there doesn't seem to be any easy way to override that behaviour.

An implication of that is that classes that **do** implement a STORE method can not be held in a $ sigiled variable. (Well, they **can**, they just won't work correctly. The first time you try to store a new value, the entire class instance will be overwritten and disappear.)

There are two work-arounds. One is to use an unsigiled variable. Unsigiled variables have no preconception of what may or may not be allowed, so don't override a STORE method. They work well, but if you really want a $ sigiled container, your only real option is to fake it using a constant term (rather than a variable.)

```raku
my \int32 = FixedInt.new; # unsigiled constant

# or

constant term:<$int32> = FixedInt.new; # "sigiled" constant term

# looks like a variable but is really a constant term
```

The FixedInt module allows creating and working with **any** sized fixed size Integer. Not only the "standard" sizes: 8, 16, 32, 64, etc., but also: 11, 25, 103, whatever. Once instantiated, it can be treated like any other variable. You can add to it, subtract from it, multiply, divide, whatever; the value stored in the variable will always stay the specified bit size. Any excesses will "roll over" the value. Works correctly for any standard bitwise or arithmatic operator, though you must remember to assign to the variable to get the fixed sized properties.

Provides some bit-wise operators that don't make sense for non-fixed size integers. Provides a few "format" operators that return a formatted IntStr; useful for display but also directly usable as an integer value.

Methods
-------

Note that most of the method examples below show binary representations of the value. That's just for demonstration purposes. Returns decimal numbers by default. All of the method examples below assume an 8 bit fixedint.

### .new()

Specify the number of bits. May be any positive integer. Defaults to 32 bit. Accepts :bit or :bits. Defaults to value of 0; will not accept a Nil value.

```raku
    my \fixedint = FixedInt.new(:8bit);

    # or

    my \fixedint = FixedInt.new(:bits(8));

    # or

    my \fixedint = FixedInt.new(bits => 8);
```

### .ror (Int $bits)

Rotate right by the given number of bits (default 1)

```raku
    # before 00000011 (3)
    fixedint.=ror(1);
    # after 10000001  (129)
```

### .rol (Int $bits)

Rotate left by the given number of bits (default 1)

```raku
    # before 10000001 (129)
    fixedint.=rol(3);
    # after 00001100 (12)
```

### .C1

Ones complement. Every bit is negated.

```raku
    # before 00001100 (12)
    fixedint.=C1;
    # after 11110011  (243)
```

### .C2

Twos complement. A "negated" integer.

```raku
    # before 00001100 (12)
    fixedint.=C2;
    # after 11110100 (244)
```

### .signed

Treats the fixed size unsigned integer as a signed integer, returns negative numbers for FixedInts with a set most significant bit.

```raku
    say fixedint        # 244
    say fixedint.signed # -12
```

### .bin

Returns a binary formatted IntStr;

```raku
    say fixedint     # 244
    say fixedint.bin # 0b11110100
```

### .oct

Returns a octal formatted IntStr;

```raku
    say fixedint     # 244
    say fixedint.oct # 0o364
```

### .hex

Returns a hex formatted IntStr;

```raku
    say fixedint     # 244
    say fixedint.hex # 0xF4
```

AUTHOR
======

Steve Schulze (thundergnat)

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Steve Schulze

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

