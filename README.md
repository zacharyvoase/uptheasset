# Up The Asset

UTA is a proof-of-concept system for [double-entry bookkeeping][deb] and
accounting, powered by standard UNIX and [RDF.rb](http://rdf.rubyforge.org).

  [deb]: http://en.wikipedia.org/wiki/Double-entry_bookkeeping_system

It is also a work-in-progress Web Ontology for accounting and bookkeeping.


## Overview

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
        uta:entry
            [ a uta:Debit ;
              uta:account <this:accounts#assets/current/cash> ;
              uta:amount 30 ] ,
            [ a uta:Credit ;
              uta:account <this:accounts#revenue/service> ;
              uta:amount 30 ] .
