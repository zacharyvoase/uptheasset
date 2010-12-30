module UTA::Models
  # An instance of <http://uptheasset.org/ontology#Account>.
  #
  # An account represents a category of resource or obligation against which
  # debits and credits are recorded.
  #
  # @example Adding metadata to an account
  #   account = Account["assets/current/cash"]
  #   account.label = "Cash"
  #   account.comment = "Cash held in the till or the company bank account."
  #   account.owner = RDF::URI.new("http://zacharyvoase.com/")
  #   account.save!
  #
  # @example Referencing accounts from transactions
  #   transaction.credit 30, Account["assets/current/cash"]
  #   transaction.debit  30, Account["revenue/services"]
  #   transaction.credit 30, Account["expenses/stationery"]
  class Account
    include Spira::Resource

    base_uri "this:accounts#"
    type RDF::UTA.Account

    property :label, :predicate => RDF::RDFS.label
    property :comment, :predicate => RDF::RDFS.comment
    property :owner, :predicate => RDF::UTA.owner
  end
end
