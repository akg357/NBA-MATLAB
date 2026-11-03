% NBA Stats Analyzer - 2024-25 regular season
% Data: github.com/willccbb/nbabench-data, data/2025/season.jsonl
% The included CSV keeps seven columns from that dataset.

clear;
clc;
close all;

% Change these names to compare different players.
player1 = "Stephen Curry";
player2 = "LeBron James";

% This is a project filter, not the official NBA scoring-title rule.
minimumGames = 58;

% Look for the CSV in the same folder as this script.
projectFolder = fileparts(mfilename('fullpath'));
data = readtable(fullfile(projectFolder, 'nba_2024_25.csv'), ...
    'TextType', 'string');

% Keep the exported charts together.
resultsFolder = fullfile(projectFolder, 'results');
if ~isfolder(resultsFolder)
    mkdir(resultsFolder);
end

% Only include players who meet the games-played filter.
qualified = data(data.gp >= minimumGames, :);
ranked = sortrows(qualified, 'pts', 'descend');
top10 = ranked(1:min(10, height(ranked)), :);

% Chart 1: highest points per game in the filtered dataset.
figure('Color', 'white', 'Position', [100 100 1000 650]);
barh(top10.pts, 'FaceColor', [0.15 0.40 0.75]);
yticks(1:height(top10));
yticklabels(top10.player);
set(gca, 'YDir', 'reverse', 'TickLabelInterpreter', 'none');
xlabel('Points per game');
title('Top 10 scorers | 2024-25 regular season');
subtitle(sprintf('Dataset players with at least %d games', minimumGames));
grid on;
exportgraphics(gcf, fullfile(resultsFolder, 'top_10_scorers.png'), ...
    'Resolution', 200);

% Chart 2: each dot represents one qualifying player.
figure('Color', 'white');
scatter(qualified.mpg, qualified.pts, 40, [0.15 0.40 0.75], 'filled');
xlabel('Minutes per game');
ylabel('Points per game');
title('Playing time and scoring | 2024-25');
subtitle(sprintf('At least %d games; association does not show causation', minimumGames));
grid on;
exportgraphics(gcf, fullfile(resultsFolder, 'minutes_vs_points.png'), ...
    'Resolution', 200);

% Find both players in the full dataset, without the games filter.
first = data(strcmpi(data.player, player1), :);
second = data(strcmpi(data.player, player2), :);

if isempty(first) || isempty(second)
    error('Player not found. Check the player names in nba_2024_25.csv.');
end

% Chart 3: compare points, rebounds, and assists per game.
values = [first.pts second.pts; first.rpg second.rpg; first.apg second.apg];
figure('Color', 'white');
bar(values);
xticks(1:3);
xticklabels({'Points', 'Rebounds', 'Assists'});
ylabel('Per game');
legend([player1 player2], 'Location', 'best', 'Interpreter', 'none');
title('Player comparison | 2024-25 regular season');
grid on;
exportgraphics(gcf, fullfile(resultsFolder, 'player_comparison.png'), ...
    'Resolution', 200);

% Show the numbers behind the first chart.
disp(top10(:, {'player', 'gp', 'pts'}));
fprintf('Charts saved in: %s\n', resultsFolder);
