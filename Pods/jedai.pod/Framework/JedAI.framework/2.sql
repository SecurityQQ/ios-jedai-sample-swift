CREATE TABLE IF NOT EXISTS Cluster
(
_id                   INTEGER PRIMARY KEY,
Latitude              REAL,
Longitude             REAL
);


CREATE TABLE IF NOT EXISTS ClusteredActivities
(
_id                   INTEGER PRIMARY KEY,
ClusterId             INTEGER,
ActivityId            INTEGER
);


CREATE TABLE IF NOT EXISTS ClusteredVisits
(
_id                   INTEGER PRIMARY KEY,
ClusterId             INTEGER,
VisitId               INTEGER
);








