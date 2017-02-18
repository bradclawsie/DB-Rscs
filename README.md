[![License BSD](https://img.shields.io/badge/License-BSD-blue.svg)](http://opensource.org/licenses/BSD-3-Clause)

# DB::Rscs

A client library for the **R**idiculously **S**imple **C**onfiguration
**S**ystem. [https://github.com/bradclawsie/rscs](https://github.com/bradclawsie/rscs)

RSCS only stores keys and values and only allows simple CRUD
operations. It is supposed to underwhelm you.

This library is a Perl6 client for RSCS.

## SYNOPSIS

```
# Assuming you have rscs running on port 8081.

use v6;
use DB::Rscs;

my $rscs = DB::Rscs.new(addr=>'http://localhost:8081');
my $val = 'val1';
my $key = 'key1';
$rscs.insert($key,$val);
my %out = $rscs.get($key);
say %out{$VALUE_KEY};
$rscs.update($key,'a new val');
$rscs.delete($key);
```

## AUTHOR

Brad Clawsie (PAUSE:bradclawsie, email:brad@b7j0c.org)

## LICENSE

This module is licensed under the BSD license, see: https://b7j0c.org/stuff/license.txt

