# Up The Asset

UTA is a proof-of-concept system for [double-entry bookkeeping][deb] and
accounting, powered by standard UNIX and [RDF.rb](http://rdf.rubyforge.org).

  [deb]: http://en.wikipedia.org/wiki/Double-entry_bookkeeping_system

It is also a work-in-progress Web Ontology for accounting and bookkeeping.


## Example

    @base <this:transactions> .
    @prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
    @prefix this: <file:///Users/zacharyvoase/personal-accounts/> .
    @prefix dc: <http://purl.org/dc/terms/> .
    @prefix uta: <http://uptheasset.org/onto/0.1/> .
    @prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

    <this:transactions#1a183830-f465-012d-dcb8-001ff3d30363> a uta:Transaction ;
        dc:date "2010-12-28Z"^^xsd:date ;
        dc:identifier <urn:uuid:1a183830-f465-012d-dcb8-001ff3d30363> ;
        uta:entry [
            uta:entryType uta:credit ;
            uta:account <this:accounts#revenue/service> ;
            uta:amount 30
        ], [
            uta:entryType uta:debit ;
            uta:account <this:accounts#assets/current/cash> ;
            uta:amount 30
        ] .
