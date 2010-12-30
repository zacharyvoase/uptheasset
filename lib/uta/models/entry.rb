module UTA::Models
  # An instance of <http://uptheasset.org/ontology#Entry>.
  #
  # An entry is a single credit or debit against an {Account}, which makes up
  # part of a transaction.
  #
  # @see http://uptheasset.org/ontology#Entry
  #   Ontology docs for Entry
  class Entry
    include Spira::Resource

    # The type of this entry.
    #
    # Should be set to either `RDF::UTA.Credit` or `RDF::UTA.Debit`.
    property :type, :predicate => RDF.type

    # The amount debited/credited with this entry.
    #
    # This is deliberately left open-ended so you can specify integers, custom
    # currency objects, etc.
    property :amount, :predicate => RDF::UTA.amount

    # The account to debit/credit.
    #
    # This should be an `RDF::URI` or an {Account}.
    property :account, :predicate => RDF::UTA.account, :type => :Account

    # Create and save a credit against a given account.
    #
    # @param [RDF::Value] amount
    #   The amount by which to credit.
    # @param [Account, RDF::URI] account
    #   The account to credit.
    #
    # @return [Entry] the created credit.
    def self.credit(amount, account)
      self.new(:type => RDF::UTA.Credit,
               :amount => amount,
               :account => account).save!
    end

    # Create and save a debit against a given account.
    #
    # @param [RDF::Value] amount
    #   The amount by which to debit.
    # @param [Account, RDF::URI] account
    #   The account to debit.
    #
    # @return [Entry] the created debit.
    def self.debit(amount, account)
      self.new(:type => RDF::UTA.Debit,
               :amount => amount,
               :account => account).save!
    end
  end
end
