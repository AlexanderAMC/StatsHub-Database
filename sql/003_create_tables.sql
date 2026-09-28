-- ==========================================
-- SCHEMA CORE
-- ==========================================

CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS sports;
CREATE SCHEMA IF NOT EXISTS payments;
CREATE SCHEMA IF NOT EXISTS notifications;
CREATE SCHEMA IF NOT EXISTS audit;

-- ==========================================
-- USUARIOS Y SEGURIDAD
-- ==========================================

CREATE TABLE core.roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE core.users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE core.user_roles (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (user_id, role_id),

    CONSTRAINT fk_user_roles_user
        FOREIGN KEY (user_id)
        REFERENCES core.users(user_id),

    CONSTRAINT fk_user_roles_role
        FOREIGN KEY (role_id)
        REFERENCES core.roles(role_id)
);

-- ==========================================
-- TORNEOS
-- ==========================================

CREATE TABLE sports.categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE sports.tournaments (
    tournament_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sports.seasons (
    season_id SERIAL PRIMARY KEY,
    tournament_id INT NOT NULL,
    season_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,

    CONSTRAINT fk_season_tournament
        FOREIGN KEY (tournament_id)
        REFERENCES sports.tournaments(tournament_id)
);

-- ==========================================
-- EQUIPOS
-- ==========================================

CREATE TABLE sports.teams (
    team_id SERIAL PRIMARY KEY,
    category_id INT,
    team_name VARCHAR(150) NOT NULL,
    logo_url TEXT,
    foundation_date DATE,

    CONSTRAINT fk_team_category
        FOREIGN KEY(category_id)
        REFERENCES sports.categories(category_id)
);

-- ==========================================
-- JUGADORES
-- ==========================================

CREATE TABLE sports.players (
    player_id SERIAL PRIMARY KEY,
    team_id INT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    jersey_number INT,
    position VARCHAR(50),

    CONSTRAINT fk_player_team
        FOREIGN KEY(team_id)
        REFERENCES sports.teams(team_id)
);

-- ==========================================
-- ENTRENADORES
-- ==========================================

CREATE TABLE sports.coaches (
    coach_id SERIAL PRIMARY KEY,
    team_id INT,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(50),
    email VARCHAR(255),

    CONSTRAINT fk_coach_team
        FOREIGN KEY(team_id)
        REFERENCES sports.teams(team_id)
);

-- ==========================================
-- ARBITROS
-- ==========================================

CREATE TABLE sports.referees (
    referee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(50)
);

-- ==========================================
-- CANCHAS
-- ==========================================

CREATE TABLE sports.venues (
    venue_id SERIAL PRIMARY KEY,
    venue_name VARCHAR(150) NOT NULL,
    address TEXT,
    capacity INT
);

-- ==========================================
-- JORNADAS
-- ==========================================

CREATE TABLE sports.matchdays (
    matchday_id SERIAL PRIMARY KEY,
    season_id INT NOT NULL,
    round_number INT NOT NULL,

    CONSTRAINT fk_matchday_season
        FOREIGN KEY(season_id)
        REFERENCES sports.seasons(season_id)
);

-- ==========================================
-- PARTIDOS
-- ==========================================

CREATE TABLE sports.matches (
    match_id SERIAL PRIMARY KEY,

    matchday_id INT NOT NULL,
    venue_id INT,

    home_team_id INT NOT NULL,
    away_team_id INT NOT NULL,

    referee_id INT,

    match_date TIMESTAMP NOT NULL,

    home_score INT DEFAULT 0,
    away_score INT DEFAULT 0,

    status VARCHAR(30) DEFAULT 'PROGRAMADO',

    CONSTRAINT fk_match_matchday
        FOREIGN KEY(matchday_id)
        REFERENCES sports.matchdays(matchday_id),

    CONSTRAINT fk_match_venue
        FOREIGN KEY(venue_id)
        REFERENCES sports.venues(venue_id),

    CONSTRAINT fk_match_home_team
        FOREIGN KEY(home_team_id)
        REFERENCES sports.teams(team_id),

    CONSTRAINT fk_match_away_team
        FOREIGN KEY(away_team_id)
        REFERENCES sports.teams(team_id),

    CONSTRAINT fk_match_referee
        FOREIGN KEY(referee_id)
        REFERENCES sports.referees(referee_id)
);

-- ==========================================
-- EVENTOS DE PARTIDO
-- ==========================================

CREATE TABLE sports.match_events (
    event_id SERIAL PRIMARY KEY,

    match_id INT NOT NULL,
    player_id INT NOT NULL,

    minute_played INT NOT NULL,

    event_type VARCHAR(50) NOT NULL,

    description TEXT,

    CONSTRAINT fk_event_match
        FOREIGN KEY(match_id)
        REFERENCES sports.matches(match_id),

    CONSTRAINT fk_event_player
        FOREIGN KEY(player_id)
        REFERENCES sports.players(player_id)
);

-- ==========================================
-- INSCRIPCIONES
-- ==========================================

CREATE TABLE payments.registrations (
    registration_id SERIAL PRIMARY KEY,

    team_id INT NOT NULL,
    season_id INT NOT NULL,

    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    amount NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_registration_team
        FOREIGN KEY(team_id)
        REFERENCES sports.teams(team_id),

    CONSTRAINT fk_registration_season
        FOREIGN KEY(season_id)
        REFERENCES sports.seasons(season_id)
);

-- ==========================================
-- PAGOS
-- ==========================================

CREATE TABLE payments.payments (
    payment_id SERIAL PRIMARY KEY,

    registration_id INT NOT NULL,

    amount NUMERIC(10,2) NOT NULL,

    payment_status VARCHAR(40),

    flow_transaction_id VARCHAR(255),

    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payment_registration
        FOREIGN KEY(registration_id)
        REFERENCES payments.registrations(registration_id)
);

-- ==========================================
-- NOTIFICACIONES
-- ==========================================

CREATE TABLE notifications.notifications (
    notification_id SERIAL PRIMARY KEY,

    user_id INT NOT NULL,

    title VARCHAR(255),

    message TEXT,

    is_read BOOLEAN DEFAULT FALSE,

    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_notification_user
        FOREIGN KEY(user_id)
        REFERENCES core.users(user_id)
);

-- ==========================================
-- AUDITORIA
-- ==========================================

CREATE TABLE audit.logs (
    log_id SERIAL PRIMARY KEY,

    table_name VARCHAR(100),

    operation_type VARCHAR(50),

    record_id INT,

    changed_by INT,

    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);