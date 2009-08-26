#   Scenario: Generate RubyGem
#     Given this project is active project folder
#     And "pkg" folder is deleted
#     When I invoke task "rake gem"
#     Then folder "pkg" is created
#     And file with name matching "pkg/*.gem" is created else you should run "rake manifest" to fix this
#     And gem spec key "rdoc_options" contains /--mainREADME.rdoc/

Feature: github wiki cloning
  In order read the wiki
  As a developer who doesn't have internet access on the train
  I want to be able copy the wiki locally
  
  Scenario: Clone Wiki
    Given this project is active project folder
    When I run project executable "bin/gh-wiki" with arguments "dpp liftweb -p tmp/lw"
    Then I should see 
      """
      dpp / liftweb
      Description:	The Lift web framework for Scala
      """
    And I should see
      """
      Pages: "About: Lift Tags"
      """
  
  Scenario: Help
    Given this project is active project folder
    When I run project executable "bin/gh-wiki" with arguments "--help"
    Then I should see
      """
      Usage: gh-wiki user project [options]
        eg. gh-wiki dpp liftweb
          -p, --path=PATH                  The path to dump the wiki to. Default: ./project
          -h, --help
      """
  
  
  
  
  
  

  
