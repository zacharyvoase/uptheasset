require 'rdf'

module RDF
  # Vocabulary for the UpTheAsset ontology.
  UTA = RDF::Vocabulary.new("http://uptheasset.org/ontology#")

  # RDF vocab for UUID URNs.
  #
  # @example Generate a UUID URN
  #   RDF::UUID[UUID.new.generate] # => <urn:uuid:xxxyyyzzz>
  UUID = RDF::Vocabulary.new("urn:uuid:")
end

# The root UpTheAsset module.
module UTA
end
