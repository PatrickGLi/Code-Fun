require 'byebug'
require 'Benchmark'

class Mailer

  def self.deliver(&block)
    # debugger
    mail = MailBuilder.new(&block).mail
    mail.send_mail
  end

  Mail = Struct.new(:from, :to, :subject, :body) do
    def send_mail
      fib(30)
      puts "Email from: #{from}"
      puts "Email to  : #{to}"
      puts "Subject   : #{subject}"
      puts "Body      : #{body}"
    end

    def fib(n)
      n < 2 ? n : fib(n-1) + fib(n-2)
    end
  end

  class MailBuilder
    def initialize(&block)
      @mail = Mail.new
      instance_eval(&block)
    end

    attr_reader :mail

    %w(from to subject body).each do |m|
      define_method(m) do |val|
        @mail.send("#{m}=", val)
      end
    end
  end
end
#
# Mailer.deliver {
#   from("eki@eqbalq.com")
#   to("jill@example.com")
#   subject("Threading and Forking")
#   body("Some content")
# }

puts Benchmark.measure{
  100.times do |i|
    Mailer.deliver do
      from    "eki_#{i}@eqbalq.com"
      to      "jill_#{i}@example.com"
      subject "Threading and Forking (#{i})"
      body    "Some content"
    end
  end
}
