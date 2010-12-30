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

    property :id, :predicate => RDF::DC.identifier
    property :date, :predicate => RDF::DC.date
    property :label, :predicate => RDF::RDFS.label
    property :comment, :predicate => RDF::RDFS.comment

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
    #   end
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
