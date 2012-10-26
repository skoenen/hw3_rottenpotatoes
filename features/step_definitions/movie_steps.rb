# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.new( movie ).save
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /[Ii] should see ["'](.*)['"] before ["'](.*)['"]/ do |e1, e2|
  movie_list = page.all( :xpath, "//table[contains( @id, 'movies' )]/tbody/tr" )

  movies = []
  movie_list.each do | movie |
    movie = movie.text.gsub( /\n/, ' | ' )
    movies << '| ' + movie
  end
  movies = movies.join

  %r(#{e1}.*#{e2}).match( movies ).should_not be_nil
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /^(?:[Ii] )((?:un)?check) the following (\w+)?: ('.+'(?:, )*)+(?: checkbox(?:es)?)?$/ do |action, prefix, boxes|
  boxes.split( /, ?/ ).each do | box |
    box.gsub!( /'/, '' )
    box = "#{prefix}_#{box}"
    send( action.to_sym, box )
  end
end
