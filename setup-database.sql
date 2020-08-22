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
('NZST', 'New Zealand Standard Time', '+12:00 UTC', +720);
