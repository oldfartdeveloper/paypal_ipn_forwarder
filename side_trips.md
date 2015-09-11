# Side Trips

This document identifies my problems, goofs, mistakes, and how I finally got
back on track while developing this project.

Some of them are still open.

I share them coz:

* Perhaps will make you feel better about your own.
* You might remember some tactics I used to get past a problem.
* You can have a good laugh at my expense.

## Turn off the incessent debug output

So I created the entire feature file and started running `mix white_bread.run`.
`white_bread` was polite about auto-generating the step definition
lines that I would need to implement the test functionality, but it
also "went nuts" with debug statements that I decided I didn't
want to see.

Simple enough, I thought, I'd just try setting the `Logging` configuration
to something like `:info` and things would quiet down.

Except they didn't.  I tried setting `config.exs`, I tried setting `dev.exs`,
I tried everything.  Gah!  Nothing worked.

Finally I went into the `Logging` project's source code to see why
the configuration wasn't "being observed" by the software.  Lo, the
documentation that I had been reading off the website was sourced
in the `Logging` source code as function comments.

Now, I can read markdown just fine, so I read further and found out
that the syntax for  what you need to put into the config file had slightly
changed.  WTF?  Then I realized that I was looking at older docs and that
`Logger` had just been released as part of the brand new **Elixir**
1.0 "production-ready" release.

### Moral

When you can't figure out why a line of code or configuration doesn't
work, go to the source code of the version you are using.
If you're lucky and you're using **Elixir**, you'll find the
source code and the source comments in the same file; you cannot
get "more sync'd" in your documentation revision accuracy than that! ;-)

## Too Much Feature Granularity

So, I find it really useful to do a "dump" of what I'm trying to do
in **Gherkin**.  But what I "dump" may not be what I want to
keep in the Gherkin as I progress in the coding.

I.e., here's my original Gherkin for the common Background task
where I'm feeling out the connections of all the pieces:

```gherkin
  Background: Launch everthing for test in the development machine
    When I launch the PayPal IPN sender simulator
    And I launch the server
    And I launch the router
    And I launch the PayPal client simulator
    When the sender simulator is configured to forward IPN notifications to the server
    And the router configures the server to send IPN acknowledgements to the sender simulator
    And the router configures the server to forward its received IPN notifications to itself
    And the router is configured to forward its received IPN notifications to the client simulator
    Then everything is configured
    ```

Now, I'm find with what I did.  I discovered:

1.  I need 4 different "components".
1.  What the connections between them need to be.

Cool!

So I attempted to implement the functionality in the step definitions.

What I discovered is that I'm having to break up the implentation into 9 pieces,
one for each step definition line resulting from the above.  While I can do
that, it doesn't impress me that the code organization is going to be
helpful in readability, number of lines of code, or performance.

So I stopped moving forward after getting the first step definition implmentation
to pass and re-assessed.  Here's the pivot plan

1.  Move the background steps into a diagram that will be easier to understand
    any ways.  This will consist of blocks interconnected w/ arrows
    describing the flow.  Knock that out in Google docs in 5 minutes.

1.  Now the `Background` step becomes:
```gherkin
Background: Launch and configure everthing
  Given that the components are launched and configured
```

Here are the gains:

1.  I regain flexibility in my coding.
1.  I can still test the overall result an my Cucumber tests
1.  The documentation is improved.
