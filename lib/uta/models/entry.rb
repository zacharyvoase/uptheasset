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

    property :type, :predicate => RDF.type
    property :amount, :predicate => RDF::UTA.amount
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
