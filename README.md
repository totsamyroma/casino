### Objective

Jackpot! You've landed a summer gig in Las Vegas! Unfortunately, it's 2020, and the casinos are closed due to COVID-19. Your boss wants to move some of the business online and asks you to build a full-stack app — a simple slot machine game, with a little twist. Build it to ensure that the house always wins!

### Brief

- When a player starts a game session, they are allocated 10 credits.
- Pulling the machine lever (rolling the slots) costs 1 credit.
- The game screen has 1 row with 3 blocks.
- For players to win the roll, they have to get the same symbol in each block.
- There are 4 possible symbols: cherry (10 credits reward), lemon (20 credits reward), orange (30 credits reward), and watermelon (40 credits reward).
- The game (session) state has to be kept on the server.
- If the player keeps winning, they can play forever, but the house has something to say about that...
- There is a CASH OUT button on the screen, which will log the user out of their game/session.

### Tasks
- Implement the assignment using any language or framework you feel comfortable with
- When a user opens the app, a session is created on the server, and they have 10 starting credits.

**Server-side:**
- When a user has less than 40 credits in the game session, their rolls are truly random.
- If a user has between 40 and 60 credits, then the server begins to slightly cheat:
  - For each winning roll, before communicating back to the client, the server does one 30% chance roll which decides if the server will re-roll that round.
    - If that roll is true, then the server re-rolls and communicates the new result back.
  - If the user has above 60 credits, the server acts the same, but in this case the chance of re-rolling the round increases to 60%.
    - If that roll is true, then the server re-rolls and communicates the new result back.
  - A winning roll does not deduct a credit - e.g. If you win with cherries, you should get +10 credits (not (+10 - 1) or 9 credits).
- There is a cash-out endpoint that moves credits from the game session to the user's account and closes the session.

**Client side:**
- Include a super simple, minimalistic table with 3 blocks in 1 row.
- Include a button next to the table that starts the game.
- The components for each sign can be a starting letter (C for cherry, L for lemon, O for orange, W for watermelon).
- After submitting a roll request to the server, all blocks should enter a spinning state (can be 'X' character spinning) or you can get fancy-pants with CSS if you like.
  - After receiving a response from the server, the first sign should spin for 1 second more and then display the result, then display the second sign at 2 seconds, then the third sign at 3 seconds.
  - If the user wins the round, their session credit is increased by the amount from the server response, else it is deducted by 1.
  - Include a button on the screen that says "CASH OUT".  When they hit it, credits from the session are moved to their account.
-   Write tests for your business logic.

### Evaluation Criteria

We are looking for high-quality, shippable code.  Note that we want you to cap your hours to a maximum of 3.  Making tradeoffs will be important, and we would like you to call out the tradeoffs you have made, and what you would have done if you had more time.

Things we'll be looking out for:
- Maintainability: Your code is written in a way that's easy to understand by other engineers.
- Testing: Critical paths are well-tested and the tests are easy to understand.
- Documentation: Your solution is well-documented.  You include documentation on how to run the app and the tests.  Your documentation includes tradeoffs made.

**BONUS:**
- The app looks nice - there is CSS that brings interactivity.
- Use of semantic markup and accessibility best practices in the frontend.
- Use of rubocop, eslint or other linting tools.

### CodeSubmit

Please organize, design, test, and document your code as if it were going into production - then push your changes to the master branch. After you have pushed your code, you may submit the assignment on the assignment page.

All the best and happy coding,

The UserEvidence Team
