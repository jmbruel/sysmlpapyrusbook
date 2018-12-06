Feature: Images
  As a reader of the HTML version of the book
  I want that no image is broken

  Scenario: No unfound image
    Given I have an "index.html" page that contains "<img "
    And I have an images directory
    When I generate HTML
    Then The "master.html" file should exist