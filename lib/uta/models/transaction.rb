require 'uuid'

module UTA::Models
  # An instance of <http://uptheasset.org/ontology#Transaction>.
  #
  # A transaction is the record of an exchange between two or more accounts in
  # a journal. Every transaction should have at least two entries (one credit,
  # one debit).
  #
  # @see http://uptheasset.org/ontology#Transaction
  #   Ontology docs for Transaction
  class Transaction
    include Spira::Resource

    base_uri "this:transactions#"
    type RDF::UTA.Transaction

    # The identifier of this transaction.
    #
    # When using {Transaction.generate}, this will be set to a `urn:uuid:` URI.
    property :id, :predicate => RDF::DC.identifier

    # The date of this transaction.
    #
    # Defaults to `Date.today` when using {Transaction.generate}.
    property :date, :predicate => RDF::DC.date

    # The label for this transaction.
    #
    # @example
    #   tr.label = "Sale of goods"
    #   tr.label = "Depreciation of car"
    #   tr.label = "Stationery purchase"
    property :label, :predicate => RDF::RDFS.label

    # Additional information about a transaction.
    #
    # @example
    #   tr.comment = "Sold some nearly-expired stock at a slight discount."
    property :comment, :predicate => RDF::RDFS.comment

    # The individual components of a transaction.
    #
    # @example
    #   tr.entries << Entry.credit(30, Account["cash"])
    #   tr.entries << Entry.debit(30, Account["expenses"])
    has_many :entries, :predicate => RDF::UTA.entry, :type => :Entry

    # Generate and save a new transaction (with its own UUID).
    #
    # @param [Hash] attributes
    #   An optional hash of attributes to set on the generated transaction.
    #
    # @yield [transaction] The generated transaction (not yet saved).
    #
    # @return [Transaction] The saved transaction.
    #
    # @example Record a sale
    #   Transaction.generate do |t|
    #     t.credit 30, RDF::URI.new("accounts#revenue")
    #     t.debit  30, RDF::URI.new("accounts#cash")
    #   end # => <this:transactions#08a155e0-f657-012d-dccf-001ff3d30363>
    def self.generate(attributes = {})
      uuid = ::UUID.new.generate
      transaction = self.for(uuid)
      transaction.id = RDF::UUID[uuid]
      transaction.date = Date.today
      transaction.update(attributes)
      yield transaction if block_given?
      transaction.save!
    end

    # Add a (saved) credit {Entry} to this transaction.
    #
    # @param [RDF::Value] amount
    #   The amount by which to credit.
    # @param [Account, RDF::URI] account
    #   The account to credit.
    # @return [Entry] the created entry.
    def credit(amount, account)
      self.entries << Entry.credit(amount, account)
    end

    # Add a (saved) debit {Entry} to this transaction.
    #
    # @param [RDF::Value] amount
    #   The amount by which to debit.
    # @param [Account, RDF::URI] account
    #   The account to debit.
    # @return [Entry] the created entry.
    def debit(amount, account)
      self.entries << Entry.debit(amount, account)
    end
  end
end
