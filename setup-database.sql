DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
  code varchar(5),
  name varchar(50) NOT NULL,
  offset varchar(10) NOT NULL,
  offset_val int(5) NOT NULL,
  PRIMARY KEY (code)
);

INSERT INTO locations VALUES 
('GMT', 'Greenwich Mean Time', '00:00 UTC' , 0),
('NZST', 'New Zealand Standard Time', '+12:00 UTC', +720),
('AEST', 'Australian Eastern Standard Time', '+10:00 UTC', +600),
('EST', 'Eastern Standard Time', '-05:00 UTC', -300),
('AoE', 'Anywhere on Earth', '-12:00 UTC', -720),
('LINT', 'Line Islands Time', '+14:00 UTC', +840),
('CHAST', 'Chatham Islands', '+12:45 UTC', +765),
('CKT', 'Cook Island Time', '-10:00 UTC', -600),
('NUT', 'Niue Time', '-11:00 UTC', -660),
('MART', 'Marquesas Time', '-09:30 UTC', -570),
('MST', 'Mountain Standard Time', '-07:00 UTC', -420),
('PST', 'Pacific Standard Time', '-08:00 UTC', -480),
('CST', 'China Standard Time', '+08:00 UTC', +480),
('JST', 'Japan Standard Time', '+09:00 UTC', +540),
('CET', 'Central European Time', '+01:00 UTC', +60);
