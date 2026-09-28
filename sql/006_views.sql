CREATE VIEW sports.vw_teams AS
SELECT
    team_id,
    team_name
FROM sports.teams;

CREATE VIEW sports.vw_players AS
SELECT
    player_id,
    first_name,
    last_name,
    position
FROM sports.players;

CREATE VIEW sports.vw_matches AS
SELECT
    match_id,
    match_date,
    home_score,
    away_score
FROM sports.matches;