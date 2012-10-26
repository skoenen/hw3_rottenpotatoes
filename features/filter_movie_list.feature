Feature: display list of movies filtered by MPAA rating

  As a concerned parent
  So that I can quickly browse movies appropriate for my family
  I want to see movies matching only certain MPAA ratings

Background: movies have been added to database

  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Amelie                  | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |

  And  I am on the RottenPotatoes home page

Scenario: restrict to movies with 'PG' or 'R' ratings
  Given I check the following ratings: 'PG', 'R'
  And i uncheck the following ratings: 'G', 'PG-13'
  When i press on 'ratings_submit' button
  Then i should see /The Terminator/
  And i should see /When Harry Met Sally/
  And i should see /Amelie/
  And i should see /The Incredibles/
  And i should see /Raiders of the Lost Ark/
  And i should not see /Aladdin/
  And i should not see /The Help/
  And i should not see /Chocolat/
  And i should not see /2001: A Space Odyssey/
  And i should not see /Chicken Run/

Scenario: no ratings selected
  Given i uncheck the following ratings: 'G', 'PG', 'PG-13', 'R'
  When i press on 'ratings_submit' button
  Then i should not see any of the movies

Scenario: all ratings selected
  Given i check the following ratings: 'G', 'PG', 'PG-13', 'R'
  When i press on 'ratings_submit' button
  Then i should see all of the movies
