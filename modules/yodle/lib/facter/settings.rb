facts = {}

if RUBY_PLATFORM =~ /darwin/
    facts["use_default_homebrew"] = true
end

facts.each do |k, v|
    unless Facter.value(k)
        Facter.add(k) { setcode { v } }
    end
end
