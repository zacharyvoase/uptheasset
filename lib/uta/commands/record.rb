require 'uta/models'

module UTA::Commands
  class Record < UTA::Command
    include UTA::Models

    def initialize(args)
      @amount = args.shift.to_i
      @credit = Account[args.shift]
      @debit = Account[args.shift]
      # TODO: parse out optional label arg, plus comment and date options.
      @label = nil
      @comment = nil
      @date = Date.today
    end

    def run
      # TODO: refactor this common pattern (of a temporary Spira repo) into a
      # simple context manager.
      repo = RDF::Repository.new
      Spira.add_repository! :default, repo

      Transaction.generate do |t|
        t.label = @label unless @label.nil?
        t.comment = @comment unless @comment.nil?
        t.date = @date
        t.credit @amount, @credit
        t.debit @amount, @debit
      end.save!

      puts repo.dump(:n3)
    end
  end
end
