NBA Stats Analyzer

1. Upload nba_analysis.m and nba_2024_25.csv into the same MATLAB Online folder.
2. Open nba_analysis.m and click Run.
3. Three PNG charts are saved in the results folder.

Change player1 and player2 near the top of the script to compare other players.
The first two charts use a 58-game minimum chosen for this project. This is not the full official NBA scoring-title eligibility rule.

Data: 2024-25 regular season, 569 player records.
Source: https://github.com/willccbb/nbabench-data
Original file: https://raw.githubusercontent.com/willccbb/nbabench-data/main/data/2025/season.jsonl
Retrieved November 3, 2026. This is a third-party dataset, not a live NBA feed.
CSV transformation: retained player, team, gp, mpg, pts, rpg, apg. Values were not changed. Team represents the end-of-season team according to the source.

Column meanings: gp = games played; mpg = minutes per game; pts = points per game; rpg = rebounds per game; apg = assists per game.

No extra MATLAB toolboxes are required. The script has not been executed in MATLAB by the authoring assistant; run it in MATLAB Online to verify the charts before adding results to your portfolio.
