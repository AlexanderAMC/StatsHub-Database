CREATE INDEX idx_users_email
ON core.users(email);

CREATE INDEX idx_team_name
ON sports.teams(team_name);

CREATE INDEX idx_player_last_name
ON sports.players(last_name);

CREATE INDEX idx_match_date
ON sports.matches(match_date);