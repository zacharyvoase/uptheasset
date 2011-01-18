# Up The Asset

UTA is a proof-of-concept system for [double-entry bookkeeping][deb] and
accounting, powered by standard UNIX and [RDF.rb][].

  [deb]: http://en.wikipedia.org/wiki/Double-entry_bookkeeping_system
  [rdf.rb]: http://rdf.rubyforge.org/

It is also a work-in-progress Web Ontology for accounting and bookkeeping.

**N.B.:** Many of the examples shown here don’t work because they haven’t been
implemented yet. Much of this document is still speculative.


## Background

Accounting and bookkeeping are essential aspects of running any business.
Usually considered dull and tedious by laymen, the books of a company provide a
unique insight into its operation. Using the information contained therein,
perhaps supplemented by data from other sources, novel ways of minimizing costs
and maximizing revenues may be revealed.

Until now, most professional accounting software has been either closed-source
or GPL. I can find no examples which observe the [UNIX philosophy][].
Extensibility is difficult even with open-source software, since most examples
are usually written in compiled languages and/or store their data in
proprietary or obscure formats.

  [unix philosophy]: http://en.wikipedia.org/wiki/Unix_philosophy

**Up The Asset** is a reimagination of accounting software for the modern age.
Based on the proven, centuries-old principle of double-entry bookkeeping, yet
using nothing but [open web standards and formats][rdf] stored in plain-text
files, it aims to bring to accounting the same breath of fresh air which
[git][] brought to version control.

  [rdf]: http://en.wikipedia.org/wiki/Resource_Description_Framework
  [git]: http://git-scm.com/

Because the system is nothing but text and cross-platform executables which
operate on that text, it is fully extensible. The use of [RDF][] means you can
supplement the core UTA vocabulary with your own domain-specific (or even
organization-specific) ontology. Scripting or extending the application itself
is easy thanks to the power of [Ruby][]. The excellent [RDF.rb][] and [Spira][]
libraries allow you to operate on the RDF data at the highest or lowest levels.

  [ruby]: http://www.ruby-lang.org/
  [spira]: http://spira.rubyforge.org/


## Architecture

### Storage

Your books are kept in a single directory, which looks like this:

    books/
    |-- attachments/
    |   |-- index
    |   `-- ... # More files (BitCache repo)
    |-- accounts # Chart of accounts
    `-- transactions # Journal

`attachments/index`, `accounts` and `transactions` all contain N3-formatted RDF
statements representing the bulk of the information held. All UTA commands read
from and/or write to these files. `attachments/` is also a
[BitCache](http://bitcache.org/) repository holding any extra files needed
(e.g. source documents like invoices and receipts).


### Interaction

#### Example: Record a transaction

This shell command:

    $ uta record 30 assets/current/cash revenue/service "Consulting" \
        --with-comment --on 2010-12-28
    Gave John Doe my services for 1 hour in exchange for $30.
    ^D

Evaluates to the following Ruby code:

    Transaction.generate do |tr|
      tr.label = "Consulting"
      tr.comment = "Gave John Doe my services for 1 hour in exchange for $30."
      tr.date = Date.civil(2010, 12, 28)
      tr.debit  30, Account["assets/current/cash"]
      tr.credit 30, Account["revenue/service"]
    end.save!

Generates this RDF (shown in Turtle):

    # Prefixes shown here for illustrative purposes.
    @base <file:///Users/zacharyvoase/books/transactions> .
    @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
    @prefix this: <file:///Users/zacharyvoase/books/> .
    @prefix dc: <http://purl.org/dc/terms/> .
    @prefix uta: <http://uptheasset.org/ontology> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    <this:transactions#1a183830-f465-012d-dcb8-001ff3d30363> a uta:Transaction ;
        dc:date "2010-12-28Z"^^xsd:date ;
        dc:identifier <urn:uuid:1a183830-f465-012d-dcb8-001ff3d30363> ;
        rdfs:label "Consulting"@en ;
        rdfs:comment "Gave John Doe my services for 1 hour in exchange for $30."@en ;
        uta:entry
            [ a uta:Debit ;
              uta:account <this:accounts#assets/current/cash> ;
              uta:amount 30 ] ,
            [ a uta:Credit ;
              uta:account <this:accounts#revenue/service> ;
              uta:amount 30 ] .


## Unlicense

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or distribute this
software, either in source code form or as a compiled binary, for any purpose,
commercial or non-commercial, and by any means.

In jurisdictions that recognize copyright laws, the author or authors of this
software dedicate any and all copyright interest in the software to the public
domain. We make this dedication for the benefit of the public at large and to
the detriment of our heirs and successors. We intend this dedication to be an
overt act of relinquishment in perpetuity of all present and future rights to
this software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
