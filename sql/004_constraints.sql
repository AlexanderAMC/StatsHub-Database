ALTER TABLE sports.players
ADD CONSTRAINT chk_players_jersey
CHECK (jersey_number > 0);

ALTER TABLE sports.matches
ADD CONSTRAINT chk_home_score
CHECK (home_score >= 0);

ALTER TABLE sports.matches
ADD CONSTRAINT chk_away_score
CHECK (away_score >= 0);

ALTER TABLE payments.payments
ADD CONSTRAINT chk_payment_amount
CHECK (amount > 0);