DELETE FROM user_roles;
DELETE FROM users;

INSERT INTO users VALUES ('keith', '{noop}keithpw', 'Keith Lee', 'keith.lee@example.com', '85212345678');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_USER');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_ADMIN');

INSERT INTO users VALUES ('sarah', '{noop}sarahpw', 'Sarah Chen', 'sarah.chen@example.com', '85233334444');
INSERT INTO user_roles(username, role) VALUES ('sarah', 'ROLE_USER');
INSERT INTO user_roles(username, role) VALUES ('sarah', 'ROLE_ADMIN');

INSERT INTO users VALUES ('mary', '{noop}marypw', 'Mary Johnson', 'mary.j@example.com', '85255556666');
INSERT INTO user_roles(username, role) VALUES ('mary', 'ROLE_USER');

INSERT INTO users VALUES ('alex', '{noop}alexpw', 'Alex Wong', 'alex.wong@example.com', '85211112222');
INSERT INTO user_roles(username, role) VALUES ('alex', 'ROLE_USER');

INSERT INTO users VALUES ('david', '{noop}davidpw', 'David Brown', 'david.b@example.com', '85277778888');
INSERT INTO user_roles(username, role) VALUES ('david', 'ROLE_USER');