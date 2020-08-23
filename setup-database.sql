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
('EST', 'Eastern Standard Time', '-05:00 UTC', -300);
